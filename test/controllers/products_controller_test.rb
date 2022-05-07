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

  test 'create a new product' do
    post products_path, params: {
      product: {
        title: 'tested',
        description: 'tested text',
        price: 45
      }
    }
    
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se creo correctamente'
  end

  test 'not create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'teste',
        price: 45
      }
    }
   
  assert_response :unprocessable_entity
  end

  test 'render an edit product form' do
    get edit_product_path(products(:one))
    
    assert_response :success
    assert_select 'form'
  end

  test 'edit a product' do
    patch product_path(products(:one)), params: {
      product: {
        price: 452
      }
    }
    
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se actualizo correctamente'
  end

  test 'fail edit a product' do
    patch product_path(products(:one)), params: {
      product: {
        price: nil
      }
    }
    
    assert_response :unprocessable_entity
  end

  
end