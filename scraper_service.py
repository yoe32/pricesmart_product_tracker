from fastapi import FastAPI
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.by import By
import time

app = FastAPI()

@app.get("/check")
def check_availability():
    options = Options()
    options.headless = True

    driver = webdriver.Firefox(options=options)

    try:
        driver.get("https://www.pricesmart.com/en-cr/product/members-selection-cat-food-chicken-and-pea-formula-6-8-kg-15-lb-755630/755630")
        time.sleep(5)  # Esperamos que el contenido cargue completamente

        available_clubs = []

        # Buscar todos los divs con la clase 'club_item'
        clubs = driver.find_elements(By.CLASS_NAME, "club_item")

        for club in clubs:
            class_attribute = club.get_attribute("class")
            club_name_element = club.find_element(By.CLASS_NAME, "club_name")
            club_name = club_name_element.get_attribute("innerText").strip()

            # Solo agregar clubes disponibles (sin clase 'unavailable_club')
            if "unavailable_club" not in class_attribute:
                available_clubs.append(club_name)

        return {
            "status": "ok",
            "available_clubs": available_clubs
        }

    except Exception as e:
        return {
            "status": "error",
            "message": str(e)
        }

    finally:
        driver.quit()
