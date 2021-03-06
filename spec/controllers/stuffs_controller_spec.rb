require 'spec_helper'

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

describe StuffsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Stuff. As you add validations to Stuff, be sure to
  # adjust the attributes here as well.
  let(:file) do
    fixture_file_upload('a.png')
  end

  let(:valid_attributes) do
    {
      title: "MyString",
      file: file,
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StuffsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all stuffs as @stuffs" do
      stuff = Stuff.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:stuffs)).to eq([stuff])
    end
  end

  describe "GET show" do
    it "assigns the requested stuff as @stuff" do
      stuff = Stuff.create! valid_attributes
      get :show, {:id => stuff.to_param}, valid_session
      expect(assigns(:stuff)).to eq(stuff)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Stuff" do
        expect {
          post :create, {:stuff => valid_attributes}, valid_session
        }.to change(Stuff, :count).by(1)
      end

      it "assigns a newly created stuff as @stuff" do
        post :create, {:stuff => valid_attributes}, valid_session
        expect(assigns(:stuff)).to be_a(Stuff)
        expect(assigns(:stuff)).to be_persisted
      end

      it "redirects to the created stuff" do
        post :create, {:stuff => valid_attributes}, valid_session
        expect(response).to redirect_to(Stuff.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved stuff as @stuff" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Stuff).to receive(:save).and_return(false)
        post :create, {:stuff => { "title" => "invalid value" }}, valid_session
        expect(assigns(:stuff)).to be_a_new(Stuff)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Stuff).to receive(:save).and_return(false)
        post :create, {:stuff => { "title" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:stuff) { Stuff.create! attrs }
    let(:attrs) { valid_attributes }
    let(:params) { {id: stuff.to_param} }

    context "when stuff has no password" do

      it "returns 404" do
        delete :destroy, params, valid_session
        expect(response.code).to eq '404'
      end
    end

    context "when stuff has password" do
      let(:attrs) do
        valid_attributes.merge(password: 'secret')
      end

      context "with correct password" do
        let(:params) { {id: stuff.to_param, password: 'secret'} }

        it "destroys the requested stuff" do
          expect {
            delete :destroy, params, valid_session
          }.to change(Stuff, :count).by(-1)
        end

        it "redirects to the stuffs list" do
          delete :destroy, params, valid_session
          expect(response).to redirect_to(stuffs_url)
        end
      end

      context "with wrong password" do
        let(:params) { {id: stuff.to_param, password: 'wrong'} }

        it "renders show template again" do
          delete :destroy, params, valid_session
          expect(assigns(:stuff)).to eq stuff
          expect(response).to render_template("show")
        end

        it "gives error in flash" do
          delete :destroy, params, valid_session
          expect(flash[:error]).not_to be_nil
        end

        it "doesn't destroy" do
          expect {
            delete :destroy, params, valid_session
          }.not_to change(Stuff, :count)
        end
      end
    end
  end

  describe "GET download" do
    let!(:stuff) do
      Stuff.create!(valid_attributes)
    end

    context "when stuff exists" do
      it "sends the file" do
        get :download, id: stuff.id

        expect(response.code).to eq '200'
        expect(response.body).to eq File.binread(file.path)
      end
    end
  end
end
