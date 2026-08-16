require "rails_helper"

RSpec.describe "Resumes API", type: :request do
  describe "GET /resumes" do
    it "returns all resumes" do
      resume1 = create(:resume)
      resume2 = create(:resume)

      get "/resumes"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.length).to eq(2)
      expect(json.map { |resume| resume["id"] }).to contain_exactly(
        resume1.id,
        resume2.id
      )
    end

    it "returns an empty array when there are no resumes" do
      get "/resumes"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end
  end

  describe "GET /resumes/:id" do
    it "returns the requested resume" do
      resume = create(:resume)

      get "/resumes/#{resume.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["id"]).to eq(resume.id)
      expect(json["title"]).to eq(resume.title)
      expect(json["user_id"]).to eq(resume.user_id)
    end

    it "returns 404 when the resume does not exist" do
      get "/resumes/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /resumes" do
    let(:user) { create(:user) }

    context "with valid parameters" do
      let(:valid_params) do
        {
          resume: {
            title: "Software Engineer Resume",
            user_id: user.id
          }
        }
      end

      it "creates a resume" do
        expect do
          post "/resumes", params: valid_params
        end.to change(Resume, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)

        expect(json["title"]).to eq("Software Engineer Resume")
        expect(json["user_id"]).to eq(user.id)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          resume: {
            title: nil,
            user_id: user.id
          }
        }
      end

      it "does not create a resume" do
        expect do
          post "/resumes", params: invalid_params
        end.not_to change(Resume, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /resumes/:id" do
    let!(:resume) { create(:resume) }

    context "with valid parameters" do
      let(:valid_params) do
        {
          resume: {
            title: "Updated Resume"
          }
        }
      end

      it "updates the resume" do
        patch "/resumes/#{resume.id}", params: valid_params

        expect(response).to have_http_status(:ok)
        expect(resume.reload.title).to eq("Updated Resume")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          resume: {
            title: nil
          }
        }
      end

      it "does not update the resume" do
        original_title = resume.title

        patch "/resumes/#{resume.id}", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(resume.reload.title).to eq(original_title)
      end
    end

    it "returns 404 when the resume does not exist" do
      patch "/resumes/999999", params: {
        resume: { title: "Updated Resume" }
      }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /resumes/:id" do
    it "deletes the resume" do
      resume = create(:resume)

      expect do
        delete "/resumes/#{resume.id}"
      end.to change(Resume, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns 404 when the resume does not exist" do
      delete "/resumes/999999"

      expect(response).to have_http_status(:not_found)
    end
  end
end
