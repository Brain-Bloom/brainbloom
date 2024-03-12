import json

# Load the JSON file
with open("courses.json", "r") as file:
    data = json.load(file)

# Replace "university" key with "author" and ensure it's the second entry in each dictionary
for entry in data:
    if "university" in entry:
        university_value = entry.pop("university")
        new_entry = {"course_name": entry.pop("course_name"), "author": university_value}
        new_entry.update(entry)  # Add the remaining key-value pairs
        entry.clear()
        entry.update(new_entry)

# Write the updated data back to the JSON file
with open("courses.json", "w") as file:
    json.dump(data, file, indent=2)
