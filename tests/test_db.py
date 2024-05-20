import psycopg2
import pytest

tables = ["category", "product", "characteristic", "seller", "advert", "price_history", "customer", "review",
          "favourite"]

executes = ["init", "function/partial", "function/trigger", "function/random", "view", "index", "trigger"]


def execute_check(test_db, test):
    test_db.execute(open("requests/" + test + ".sql", "r").read())
    assert str(test_db.fetchall()) == open("output/" + test + ".out", "r").read()


@pytest.fixture
def test_db():
    dbconnect = psycopg2.connect(database="postgres", user='postgres', password='postgres', host='localhost',
                                 port='5432')
    dbconnect.autocommit = True
    cursor = dbconnect.cursor()

    for execute in executes:
        cursor.execute(open(execute + ".sql").read())
    for table in tables:
        cursor.copy_expert("COPY marketplace." + table + " FROM STDIN DELIMITER ',' CSV HEADER",
                           open("data/" + table + ".csv", "r"))

    yield cursor

    cursor.execute(open("drop.sql").read())
    cursor.close()
    dbconnect.close()


def test_product_mark(test_db):
    """Выводим среднюю оценку товара"""
    execute_check(test_db, "product_mark")


def test_customer_names(test_db):
    """Выводим имена всех пользователей, которые родились в 1899 году, отсортированные по имени"""
    execute_check(test_db, "customer_names")


def test_product_insert(test_db):
    """Добавляем товар и проверяем его наличие"""
    execute_check(test_db, "product_insert")


def test_product_delete(test_db):
    """Удаляем товар и проверяем его отсутствие"""
    execute_check(test_db, "product_delete")


def test_price_history_minmax(test_db):
    """Выводим имя товара, среднюю, минимальную и максимальную цену по товарам, отсортированные по названию товара"""
    execute_check(test_db, "price_history_minmax")


def test_seller_advert(test_db):
    """Выводим имя продавца и количество объявлений для тех, у кого их больше 10,
    отсортированные по количеству объявлений по убыванию"""
    execute_check(test_db, "seller_advert")


def test_advert_product(test_db):
    """Выводим все объявления, которые относятся к товарам, начинающимся с 4"""
    execute_check(test_db, "advert_product")


def test_customer_email(test_db):
    """Обновляем адреса электронной почты пользователей, у которых фамилия содержит 11"""
    execute_check(test_db, "customer_email")


def test_characteristic_product(test_db):
    """Выводим список товаров с заданной характеристикой, у которых оценка больше 3"""
    execute_check(test_db, "characteristic_product")


def test_product_rank(test_db):
    """Выводим список товаров, ранжируя в обратном порядке по количеству людей,
    которые отметили их как избранные, и сортируя по рангу и имени"""
    execute_check(test_db, "product_rank")


def test_category_product(test_db):
    """Выводим список товаров в 2 данных категориях 2 и 20"""
    execute_check(test_db, "category_product")
