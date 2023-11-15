from pynamodb.models import Model

from orm import Course


# Récupérer les dix premiers éléments de la base de données
courses = Course.scan(limit=10)

course_ = [course.course_rating for course in courses]

print(universities)
