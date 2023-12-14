import json
import random

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel

# Load the JSON data
with open('../../dataset/courses/courses.json', 'r') as file:
    courses = json.load(file)

# Extract course descriptions, URLs, and difficulty levels
descriptions = [course['course_description'] for course in courses]
urls = [course['course_url'] for course in courses]
difficulty_levels = [course['difficulty_level'] for course in courses]

# Vectorize the course descriptions using TF-IDF
vectorizer = TfidfVectorizer(stop_words='english')
tfidf_matrix = vectorizer.fit_transform(descriptions)


def recommend_courses_from_url(course_url, num_recommendations=5):
    # Find the index of the course in the dataset
    index = urls.index(course_url)

    # Get the difficulty level of the selected course
    selected_difficulty = difficulty_levels[index]

    # Calculate cosine similarity between the selected course and all other courses
    cosine_similarities = linear_kernel(tfidf_matrix[index], tfidf_matrix).flatten()

    # Adjust similarity scores based on difficulty level
    for i, difficulty in enumerate(difficulty_levels):
        if difficulty == selected_difficulty:
            cosine_similarities[i] += 0.1  # Increase similarity for courses with the same difficulty

    # Get the indices of courses with highest similarity
    similar_courses_indices = cosine_similarities.argsort()[:-num_recommendations - 1:-1]

    # Print the recommended courses and their URLs
    print(f"Recommended courses for {courses[index]['course_name']} ({course_url}):")
    for i, course_index in enumerate(similar_courses_indices):
        print(f"{i + 1}. {courses[course_index]['course_name']} - {courses[course_index]['course_url']}")


def recommend_courses_from_skills(preferred_skills, difficulty_level, num_recommendations=12):
    # Combine preferred skills into a single string (you can modify this based on your actual data)
    preferred_skills_str = ' '.join(preferred_skills)

    # Vectorize the preferred skills
    preferred_skills_vector = vectorizer.transform([preferred_skills_str])

    # Calculate cosine similarity between the preferred skills and all courses
    cosine_similarities = linear_kernel(preferred_skills_vector, tfidf_matrix).flatten()

    # Adjust similarity scores based on difficulty level
    for i, difficulty in enumerate(difficulty_levels):
        if difficulty == difficulty_level:
            cosine_similarities[i] += 0.1  # Increase similarity for courses with the same difficulty

    # Get the indices of courses with the highest similarity
    similar_courses_indices = cosine_similarities.argsort()[:-num_recommendations - 1:-1]

    # Return the recommended courses and their URLs
    recommended_courses = [
        {
            "course_name": courses[course_index]['course_name'],
            "course_url": courses[course_index]['course_url']
        }
        for course_index in similar_courses_indices
    ]

    return recommended_courses
