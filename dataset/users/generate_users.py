import json
import random
from recommendation.content_based.recommendation_algorithm import recommend_courses_from_skills

# Read course names from "courses.json"
with open("../courses/courses.json", "r") as courses_file:
    courses_data = json.load(courses_file)
    course_urls = [course["course_url"] for course in courses_data]

# Expanded list of professions and preferred topics
professions = [
    ("Software Engineer", "Master's Degree"),
    ("Data Scientist", "Master's Degree"),
    ("Data Analyst", "Bachelor's Degree"),
    ("Student", "High School"),
    ("Teacher", "Bachelor's Degree"),
    ("Graphic Designer", "Bachelor's Degree"),
    ("Marketing Specialist", "Bachelor's Degree"),
    ("Nurse", "Bachelor's Degree"),
    ("Architect", "Master's Degree"),
    ("Chef", "High School"),
    ("Journalist", "Bachelor's Degree"),
    ("Financial Analyst", "Bachelor's Degree"),
    ("Biologist", "Ph.D."),
    ("Civil Engineer", "Bachelor's Degree"),
    ("Psychologist", "Ph.D."),
    ("Electrician", "High School"),
    ("Lawyer", "Ph.D."),
    ("Librarian", "Master's Degree"),
    ("Pharmacist", "Ph.D."),
    ("Social Worker", "Master's Degree"),
    ("Physicist", "Ph.D."),
    ("Police Officer", "High School"),
    ("Pilot", "Bachelor's Degree"),
    ("Mechanical Engineer", "Bachelor's Degree"),
    ("Dentist", "Ph.D."),
    ("Artist", "Bachelor's Degree"),
    ("Veterinarian", "Ph.D."),
    ("IT Consultant", "Bachelor's Degree"),
    ("Speech Therapist", "Master's Degree"),
    ("Translator", "Bachelor's Degree"),
    ("Fitness Trainer", "Bachelor's Degree"),
    ("Economist", "Ph.D."),
    ("Geologist", "Master's Degree"),
    ("Software Developer", "Bachelor's Degree"),
    ("HR Specialist", "Bachelor's Degree"),
    ("Mathematician", "Ph.D."),
    ("Astronomer", "Ph.D."),
    ("Robotics Engineer", "Master's Degree"),
    ("Interior Designer", "Bachelor's Degree"),
    ("Event Planner", "Bachelor's Degree"),
    ("Biomedical Engineer", "Master's Degree"),
    ("Air Traffic Controller", "Bachelor's Degree"),
    ("Insurance Agent", "Bachelor's Degree"),
    ("Zoologist", "Ph.D."),
    ("Meteorologist", "Master's Degree"),
    ("Archaeologist", "Ph.D."),
    ("Forensic Scientist", "Ph.D."),
    ("Paramedic", "Bachelor's Degree"),
    ("Cartographer", "Bachelor's Degree"),
    ("Flight Attendant", "High School")
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
    "Space Exploration", "Renewable Energy", "Urban Planning", "Marine Biology",
    "Art History", "Medicine", "Astronomy", "Geology", "Anthropology",
    "Archaeology", "Computer Science", "Literature", "Sustainable Living",
    "Social Media Management", "Ethical Hacking", "Public Speaking", "Business Strategy",
    "Fashion Styling", "Game Design", "Quantum Mechanics", "Educational Technology",
    "Human Rights", "Climate Change", "Wildlife Conservation", "Futurism",
    "Data Visualization", "Biotechnology", "Sports Science", "Theater Arts",
    "Mobile Photography", "User Experience Design", "Data Ethics", "Augmented Reality",
    "Renewable Technology", "Bioinformatics", "Educational Psychology", "Behavioral Economics",
    "Virtual Assistant Development", "Science Fiction Literature", "Blockchain Applications",
    "Personal Finance Management", "Mental Health Awareness", "Cryptocurrency Trading", "Health Informatics",
    "Environmental Sustainability", "Fintech Innovations", "Green Architecture", "Marine Conservation",
    "Social Entrepreneurship", "Inclusive Design", "Mindfulness Practices", "Remote Sensing Technology",
    "Aerospace Engineering", "Quantum Computing", "Natural Language Processing", "Disaster Management",
    "Quantum Biology", "Social Justice Issues", "Renewable Energy Policy", "Molecular Gastronomy",
    "Ethical Fashion", "Community Gardening", "Home Automation", "DIY Home Decor",
    "Artificial General Intelligence", "Exoplanet Exploration", "Behavioral Ecology",
    "Renewable Energy Entrepreneurship",
    "Neuroaesthetics", "Educational Gamification", "Biohacking", "Sustainable Fashion Design",
    "Space Tourism", "Cognitive Neuroscience", "Edible Insect Farming", "Personalized Medicine"
]


# Generate a list of 300 users
def generate_users(n):
    users = []
    for user_id in range(0, n):
        profession = random.choice(professions)
        user = {
            "user_id": user_id,
            "demographics": {
                "age": random.randint(16, 70),
                "gender": random.choice(["Male", "Female"]),
                "education_level": profession[1],
                "profession": profession[0]
            },
            "preferences": {
                "preferred_difficulty": random.choice(["Beginner", "Intermediate", "Advanced", "Not Calibrated"]),
                "preferred_skills": random.sample(preferred_topics, 3),
            },
        }

        # Get content-based recommendations based on preferred skills
        recommended_courses = recommend_courses_from_skills(user["preferences"]["preferred_skills"],
                                                            user["preferences"]["preferred_difficulty"],
                                                            random.randint(0, 12))

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
    return users


# Save the generated dataset to a JSON file
def save_to_json(filename):
    with open(filename, "w") as output_file:
        json.dump(generate_users(1000), output_file, indent=2)

    print("Generated dataset saved to ", filename)

# save_to_json("users.json")
