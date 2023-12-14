import json
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity

# Load data
with open('../../dataset/users/users.json', 'r') as file:
    users_data = json.load(file)

with open('../../dataset/courses/courses.json', 'r') as file:
    courses_data = json.load(file)

# Build user-item matrix
user_item_matrix = np.zeros((len(users_data), len(courses_data)))

for i, user in enumerate(users_data):
    for interaction in user['interactions']:
        course_url = interaction['course_url']['course_url']
        course_index = next((index for index, course in enumerate(courses_data) if course['course_url'] == course_url), None)
        if course_index is not None:
            user_item_matrix[i, course_index] = interaction['rating']

# Calculate cosine similarity between users
user_similarity_matrix = cosine_similarity(user_item_matrix)

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
# Sort and return recommendations
def get_rating(course_url):
    course_index = next((index for index, course in enumerate(courses_data) if course['course_url'] == course_url), None)
    rating = courses_data[course_index]['course_rating']
    try:
        return float(rating)
    except (ValueError, TypeError):
        return 0.0  # Default to 0.0 if conversion fails

sorted_recommendations = sorted(recommendations, key=lambda x: get_rating(x), reverse=True)

print("Recommended courses:")
for course_url in sorted_recommendations:
    course_index = next((index for index, course in enumerate(courses_data) if course['course_url'] == course_url), None)
    print(courses_data[course_index]['course_name'], course_url)

