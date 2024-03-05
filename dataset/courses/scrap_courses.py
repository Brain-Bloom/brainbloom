from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException

import json
from dataset.users.generate_users import preferred_topics

# Initialize Edge WebDriver
options = webdriver.EdgeOptions()
options.add_argument("--lang=en")  # Set language to English
driver = webdriver.Edge(options=options)
options.add_argument("-headless")

scraped_courses = []

for keyword in preferred_topics:
    # URL of the webpage
    url = f"https://www.linkedin.com/learning/search?entityType=COURSE&keywords={keyword}"

    # Open the webpage
    driver.get(url)

    # Find the element using XPath
    try:
        element = driver.find_element(By.XPATH, '/html/body/div/div[2]/main/section/ul/li[2]/div/a')
    except NoSuchElementException:
        try:
            element = driver.find_element(By.XPATH, '/html/body/div/div[2]/main/section/ul/li[1]/div/a')
        except NoSuchElementException:
            element = ""

    course_url_element = element.get_attribute("href")

    # Click on the first result
    element.click()

    # Extract course title
    course_title_element = driver.find_element(By.XPATH, '/html/body/main/section[1]/section/div/div/div/h1').text

    # Extract course description
    course_description_element = driver.find_element(By.XPATH,
                                                     '/html/body/main/section[1]/div/section[1]/div/section/div').text

    # Extract course difficulty
    course_difficulty_element = \
        driver.find_element(By.XPATH, '/html/body/main/section[1]/section/div/div/div/h2/div[2]/span[2]').text.split()[
            -1]

    # Extract course author
    course_author_element = driver.find_element(By.XPATH,
                                                '/html/body/main/section[1]/section/div/div/div/h2/div[1]/span[1]').text.split()[
                            1:]
    course_author_element = ' '.join(str(e) for e in course_author_element)

    # Extract course rating
    try:
        course_rating_element = driver.find_element(By.XPATH,
                                                    '/html/body/main/section[1]/div/section[5]/div/div/section/div[1]/h3/span[1]').text
    except NoSuchElementException:
        try:
            course_rating_element = driver.find_element(By.XPATH,
                                                        '/html/body/main/section[1]/div/section[4]/div/div/section/div[1]/h3/span[1]').text
        except NoSuchElementException:
            course_rating_element = ""

    # Extract course skills
    try:
        course_skills_element = driver.find_element(By.XPATH,
                                                    '/html/body/main/section[1]/div/section[2]/div/ul/li/a').text
    except NoSuchElementException:
        course_skills_element = ""

    # Create a dictionary for the scraped course
    scraped_course = {
        "course_name": course_title_element,
        "author": course_author_element,
        "difficulty_level": course_difficulty_element,
        "course_rating": course_rating_element,
        "course_url": course_url_element,
        "course_description": course_description_element,
        "skills": course_skills_element
    }

    # Add the scraped course to the list
    if scraped_course not in scraped_courses:
        scraped_courses.append(scraped_course)

# Close the browser
driver.quit()


# Write scraped courses to a JSON file
def save_to_json(filename):
    with open(filename, 'w') as json_file:
        json.dump(scraped_courses, json_file, indent=2)

    print("Generated dataset saved to ", filename)


save_to_json('scraped_courses.json')
