from pynamodb.models import Model
from pynamodb.attributes import UnicodeAttribute, NumberAttribute, ListAttribute, MapAttribute

class Course(Model):
    class Meta:
        table_name = 'dev-courses'
        region = 'eu-west-1'  # Choisir votre région AWS
        aws_access_key_id = "AKIAVQGNYBAE3LZEFECW"
        aws_secret_access_key = "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"


    course_url = UnicodeAttribute(hash_key=True)
    course_name = UnicodeAttribute()
    university = UnicodeAttribute()
    difficulty_level = UnicodeAttribute()
    course_rating = NumberAttribute()
    course_description = UnicodeAttribute()
    skills = ListAttribute(of=UnicodeAttribute)


# Supposons que 'data' est la liste des données que vous avez fournie

# Récupérer un cours spécifique par son nom
queried_course = Course.get("Your Course Name")

# Vérifier et afficher les détails du cours récupéré
if queried_course:
    print("Queried Course Name:", queried_course.course_name)
    print("University:", queried_course.university)
    # Afficher d'autres détails du cours comme nécessaire
else:
    print("Ce cours n'a pas été trouvé dans la base de données.")


