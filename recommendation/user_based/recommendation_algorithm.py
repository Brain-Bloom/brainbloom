import json
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity

# Load data
with open('../../dataset/users/users.json', 'r') as file:
    users_data = json.load(file)

with open('../../dataset/courses/courses.json', 'r') as file:
    courses_data = json.load(file)


def get_rating(course_url):
    course_index = next(
        (index for index, course in enumerate(courses_data) if course['course_url'] == course_url),
        None)
    if course_index is not None:
        rating = courses_data[course_index]['course_rating']
        try:
            return float(rating)
        except (ValueError, TypeError):
            return 0.0  # Default to 0.0 if conversion fails
    return 0.0


# Build user-item matrix
user_item_matrix = np.zeros((len(users_data), len(courses_data)))

# Step 1: Calculate Mean and Standard Deviation
user_ratings_mean = np.zeros(len(users_data))
user_ratings_std = np.zeros(len(users_data))

for i, user in enumerate(users_data):
    ratings = [interaction['rating'] for interaction in user['interactions']]
    user_ratings_mean[i] = np.mean(ratings)
    user_ratings_std[i] = np.std(ratings)

# Step 2: Normalize Ratings in the User-Item Matrix
for i, user in enumerate(users_data):
    for interaction in user['interactions']:
        course_url = interaction['course_url']['course_url']
        course_index = next((index for index, course in enumerate(courses_data) if course['course_url'] == course_url),
                            None)
        if course_index is not None:
            # Normalize Rating using Z-score normalization
            raw_rating = interaction['rating']
            normalized_rating = (raw_rating - user_ratings_mean[i]) / (
                        user_ratings_std[i] + 1e-8)  # Adding a small value to avoid division by zero
            user_item_matrix[i, course_index] = normalized_rating

# Calculate cosine similarity between users
user_similarity_matrix = cosine_similarity(user_item_matrix)

# Build user-item matrix
user_item_matrix = np.zeros((len(users_data), len(courses_data)))

# Build user features matrix
user_features_matrix = np.zeros((len(users_data), 3))  # Sex, Age, Profession

for i, user in enumerate(users_data):
    for interaction in user['interactions']:
        course_url = interaction['course_url']['course_url']
        course_index = next((index for index, course in enumerate(courses_data) if course['course_url'] == course_url),
                            None)
        if course_index is not None:
            user_item_matrix[i, course_index] = interaction['rating']

    # Populate user features
    user_features_matrix[i, 0] = 1 if user['demographics']['gender'] == 'Male' else 0  # Encode gender as binary
    user_features_matrix[i, 1] = user['demographics']['age']
    user_features_matrix[i, 2] = hash(user['demographics']['profession'])  # Hash profession for simplicity

# Normalize user-item matrix
user_item_matrix_normalized = user_item_matrix - user_item_matrix.mean(axis=1, keepdims=True)

# Combine user-item matrix and user features matrix
user_matrix_combined = np.hstack((user_item_matrix_normalized, user_features_matrix))

# Calculate cosine similarity between users based on combined matrix
user_similarity_matrix = cosine_similarity(user_matrix_combined)

# Example for a target user (replace with actual user data)
target_user_index = 0
target_user_interactions = users_data[target_user_index]['interactions']

# Find similar users
similar_users_indices = np.argsort(user_similarity_matrix[target_user_index])[::-1][1:]  # Exclude the target user

# Generate recommendations
recommendations = []
for similar_user_index in similar_users_indices:
    similar_user_interactions = users_data[similar_user_index]['interactions']
    for interaction in similar_user_interactions:
        course_url = interaction['course_url']['course_url']
        if course_url not in [interaction['course_url']['course_url'] for interaction in target_user_interactions]:
            recommendations.append(course_url)

# Remove duplicates and handle already interacted courses
recommendations = list(set(recommendations))

# Sort and return recommendations
sorted_recommendations = sorted(recommendations, key=lambda x: get_rating(x), reverse=True)

print("Recommended courses:")
for course_url in sorted_recommendations:
    course_index = next((index for index, course in enumerate(courses_data) if course['course_url'] == course_url),
                        None)
    print(courses_data[course_index]['course_name'], course_url)
