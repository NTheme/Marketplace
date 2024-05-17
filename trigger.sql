--- При удалении пользователя так же удаляем его избранные и написанные им отзывы
CREATE OR REPLACE TRIGGER clear_user_data
    BEFORE DELETE
    ON marketplace.customer
    FOR EACH ROW
EXECUTE PROCEDURE CLEAR_USER_DATA();

--- При удалении продавца так же удаляем его объявления и историю цен на них
CREATE OR REPLACE TRIGGER clear_seller_data
    BEFORE DELETE
    ON marketplace.seller
    FOR EACH ROW
EXECUTE PROCEDURE CLEAR_SELLER_DATA();

--- При удалении товара так же удаляем все связанные с ним объявления, их историю цен, отзывы и характеристики
CREATE OR REPLACE TRIGGER clear_product_data
    BEFORE DELETE
    ON marketplace.product
    FOR EACH ROW
EXECUTE PROCEDURE CLEAR_PRODUCT_DATA();

--- Сохраняем историю изменений цены при создании нового объявления
CREATE OR REPLACE TRIGGER evaluate_history
    AFTER INSERT OR UPDATE
    ON marketplace.advert
    FOR EACH ROW
EXECUTE PROCEDURE EVALUATE_HISTORY();

-- Обновляем текущую цену при создании новой записи о цене
CREATE OR REPLACE TRIGGER evaluate_advert
    AFTER INSERT
    ON marketplace.price_history
    FOR EACH ROW
EXECUTE PROCEDURE EVALUATE_ADVERT();
