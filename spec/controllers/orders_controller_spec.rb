require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe OrdersController, type: :controller do

  before(:example) do
    @user = create :user
    @user.confirm
    sign_in :user, @user
  end

  # This should return the minimal set of attributes required to create a valid
  # Order. As you add validations to Order, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    product = create :product
    create :cart, user: @user, product: product, number: 1
    { user: @user, comment: "{ phone: '18018018018' }" }
  end

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OrdersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do

    it "render index view if request as html" do
      get :index, format: :json
      expect(response).to render_template(:index)
    end

    it "assigns all orders as @orders" do
      order = Order.place_order valid_attributes
      get :index, format: :json
      expect(assigns(:orders)).to eq([order])
    end
  end

  describe "GET #show" do
    it "assigns the requested order as @order" do
      order = Order.place_order valid_attributes
      get :show, {:uid => order.uid, format: :json}
      expect(assigns(:order)).to eq(order)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Order" do
        product = create :product
        create :cart, user: @user, product: product, number: 1
        expect {
          post :create, comment: '{"phone":"18018018018"}', format: :json
        }.to change(Order, :count).by(1)
      end
    end

    context "cart is empty" do
      it "redirects to the products list" do
        post :create, comment: '{"phone":"18018018018"}', format: :json
        expect(response).to have_http_status(400)
        expect(response.body).to eq('carts is empty')
      end
    end
  end

end