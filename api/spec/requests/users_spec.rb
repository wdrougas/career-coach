require "rails_helper"

RSpec.describe "Users API", type: :request do
  describe "GET /users" do
    it "returns all users" do
      user1 = create(:user)
      user2 = create(:user)

      get "/users"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.length).to eq(2)
      expect(json.map { |user| user["id"] }).to contain_exactly(
        user1.id,
        user2.id
      )
    end

    it "returns an empty array when there are no users" do
      get "/users"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end
  end

  describe "GET /users/:id" do
    it "returns the requested user" do
      user = create(:user)

      get "/users/#{user.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["id"]).to eq(user.id)
      expect(json["email"]).to eq(user.email)
    end

    it "returns 404 when the user does not exist" do
      get "/users/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /users" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            email: "newuser@example.com"
          }
        }
      end

      it "creates a user" do
        expect do
          post "/users", params: valid_params
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)

        expect(json["email"]).to eq("newuser@example.com")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          user: {
            email: nil
          }
        }
      end

      it "does not create a user" do
        expect do
          post "/users", params: invalid_params
        end.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /users/:id" do
    let!(:user) { create(:user) }

    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            email: "updated@example.com"
          }
        }
      end

      it "updates the user" do
        patch "/users/#{user.id}", params: valid_params

        expect(response).to have_http_status(:ok)

        expect(user.reload.email).to eq("updated@example.com")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          user: {
            email: nil
          }
        }
      end

      it "does not update the user" do
        patch "/users/#{user.id}", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(user.reload.email).not_to be_nil
      end
    end

    it "returns 404 when the user does not exist" do
      patch "/users/999999", params: {
        user: {
          email: "updated@example.com"
        }
      }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /users/:id" do
    it "deletes the user" do
      user = create(:user)

      expect do
        delete "/users/#{user.id}"
      end.to change(User, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns 404 when the user does not exist" do
      delete "/users/999999"

      expect(response).to have_http_status(:not_found)
    end
  end
end
