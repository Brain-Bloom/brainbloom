import json
import random
from recommendation.content_based.recommendation_algorithm import recommend_courses_from_skills

# Read course names from "courses.json"
with open("../courses/courses.json", "r") as courses_file:
    courses_data = json.load(courses_file)
    course_urls = [course["course_url"] for course in courses_data]

# Expanded list of professions and preferred topics
professions = [
    "Software Engineer", "Data Scientist", "Data Analyst", "Student",
    "Teacher", "Graphic Designer", "Marketing Specialist", "Nurse",
    "Architect", "Chef", "Journalist", "Financial Analyst",
    "Biologist", "Civil Engineer", "Psychologist", "Electrician",
    "Lawyer", "Librarian", "Pharmacist", "Social Worker",
    "Physicist", "Police Officer", "Pilot", "Mechanical Engineer",
    "Dentist", "Artist", "Veterinarian", "IT Consultant",
    "Speech Therapist", "Translator", "Fitness Trainer", "Economist",
    "Geologist", "Software Developer", "HR Specialist", "Mathematician",
    "Electrician", "Astronomer", "Robotics Engineer", "Interior Designer",
    "Event Planner", "Biomedical Engineer", "Air Traffic Controller",
    "Insurance Agent", "Zoologist", "Meteorologist", "Archaeologist",
    "Forensic Scientist", "Paramedic", "Cartographer", "Flight Attendant"
]

preferred_topics = [
    "Data Science", "Web Development", "Business Analytics",
    "Python Programming", "Artificial Intelligence", "Photography",
    "Marketing", "History", "Psychology", "Sociology",
    "Physics", "Biology", "Philosophy", "Environmental Science",
    "Mathematics", "Cooking", "Music", "Fashion Design", "Languages",
    "Graphic Design", "Digital Marketing", "Chemistry", "Astrophysics",
    "Game Development", "Machine Learning", "Blockchain", "Finance",
    "Health and Fitness", "Robotics", "Economics", "Cryptocurrency",
    "Travel", "Creative Writing", "Philanthropy", "Film Production",
    "Political Science", "Gardening", "Yoga", "Neuroscience",
    "Mobile App Development", "Cybersecurity", "3D Printing", "Virtual Reality",
    "Interior Design", "Culinary Arts", "Animation", "DIY Crafts",
    "Space Exploration", "Renewable Energy", "Urban Planning", "Marine Biology"
]


# Generate a list of 300 users
users = []
for user_id in range(1, 301):
    user = {
        "user_id": user_id,
        "demographics": {
            "age": random.randint(16, 70),
            "gender": random.choice(["Male", "Female"]),
            "education_level": random.choice(["High School", "Bachelor's Degree", "Master's Degree", "Ph.D."]),
            "profession": random.choice(professions)
        },
        "preferences": {
            "preferred_difficulty": random.choice(["Beginner", "Intermediate", "Advanced", "Not Calibrated"]),
            "preferred_skills": random.sample(preferred_topics, 3),
        },
    }

    # Get content-based recommendations based on preferred skills
    recommended_courses = recommend_courses_from_skills(user["preferences"]["preferred_skills"], user["preferences"]["preferred_difficulty"])

    # Add interactions with recommended courses
    user["interactions"] = [
        {
            "course_url": recommended_course,
            "rating": random.randint(1, 5),
            "completed": random.choice([True, False])
        }
        for recommended_course in recommended_courses
    ]

    users.append(user)

# Save the generated dataset to a JSON file
output_data = {"users": users}
with open("users.json", "w") as output_file:
    json.dump(output_data, output_file, indent=2)

print("Generated dataset saved to 'users.json'")
