require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    #le pasamos una clase al select que luego colocamos en el itenerador de products en index
    #y le pasamos que esperamos 2 productos para realizar la prueba 
    #ya definidos en los fixtures de minitest
    assert_select '.product', 2
  end   

  test 'render detail product page' do
    #ESTA LINEA SE LEE DE LA SIGUIENTE MANERA:
    #EL PATH DE PRODUCT LUEGO '/products/id'
    get product_path(products(:one))

    assert_response :success
    #esperamos que la pagina renderise un titulo en html
    assert_select '.title', 'ps4'
    assert_select '.description', 'en buen estado'
    assert_select '.price', '200$'
  end

  test 'render a new product form' do
    get new_product_path
    
    assert_response :success
    assert_select 'form'
  end
end