from selenium import webdriver
from selenium.webdriver.common.by import By

# Path to the GeckoDriver executable
webdriver_path = 'Users\g501d\Downloads\geckodriver-v0.32.1-win64'

# Initialize Firefox WebDriver
options = webdriver.EdgeOptions()
driver = webdriver.Edge(options=options)
options.add_argument("-headless")

# URL of the webpage
url = "https://www.linkedin.com/learning/search?entityType=COURSE&keywords=python"

# Open the webpage
driver.get(url)

# Find the element using XPath
element = driver.find_element(By.XPATH, '//*[@id="main-content"]/section/ul/li[1]/div/div[2]/h3')

# Print the text content of the element
if element:
    print("Found element with XPath:")
    print(element.text.strip())
else:
    print("Element not found")

# Close the browser
driver.quit()