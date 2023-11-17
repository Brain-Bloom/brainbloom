from orm.orm import Course
from recommendation.content_based import recommendation_algorithm as ra

# Ensure the existing table is available
if not Course.exists():
    print("Table 'dev-courses' does not exist. Please create the table first.")
else:
    # Query the data
    queried_course_key = "https://www.coursera.org/learn/global-health-overview"

    # Use the model to get the course by course_url
    queried_course = Course.get(queried_course_key).course_url

    # Perform recommendation using the queried course
    ra.recommend_courses(queried_course)

