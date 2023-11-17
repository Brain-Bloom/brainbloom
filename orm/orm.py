from pynamodb.models import Model
from pynamodb.attributes import UnicodeAttribute, NumberAttribute, ListAttribute, MapAttribute


class Course(Model):
    class Meta:
        table_name = 'dev-courses'
        region = 'eu-west-1'  # Choisir votre région AWS

    course_url = UnicodeAttribute(hash_key=True)
    course_name = UnicodeAttribute()
    university = UnicodeAttribute()
    difficulty_level = UnicodeAttribute()
    course_rating = NumberAttribute()
    course_description = UnicodeAttribute()
    skills = UnicodeAttribute()
