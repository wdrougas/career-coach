require "rails_helper"

RSpec.describe "Jobs API", type: :request do
  describe "GET /jobs" do
    it "returns all jobs" do
      job1 = create(:job)
      job2 = create(:job)

      get "/jobs"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.length).to eq(2)
      expect(json.map { |job| job["id"] }).to contain_exactly(
        job1.id,
        job2.id
      )
    end

    it "returns an empty array when there are no jobs" do
      get "/jobs"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end
  end

  describe "GET /jobs/:id" do
    it "returns the requested job" do
      job = create(:job)

      get "/jobs/#{job.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["id"]).to eq(job.id)
      expect(json["company"]).to eq(job.company)
      expect(json["title"]).to eq(job.title)
      expect(json["description"]).to eq(job.description)
    end

    it "returns 404 when the job does not exist" do
      get "/jobs/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /jobs" do
    let(:user) { create(:user) }

    context "with valid parameters" do
      let(:valid_params) do
        {
          job: {
            company: "OpenAI",
            title: "Software Engineer",
            description: "Build AI products.",
            user_id: user.id
          }
        }
      end

      it "creates a job" do
        expect do
          post "/jobs", params: valid_params
        end.to change(Job, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)

        expect(json["company"]).to eq("OpenAI")
        expect(json["title"]).to eq("Software Engineer")
        expect(json["user_id"]).to eq(user.id)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          job: {
            company: nil,
            title: "Software Engineer",
            description: "Build AI products.",
            user_id: user.id
          }
        }
      end

      it "does not create a job" do
        expect do
          post "/jobs", params: invalid_params
        end.not_to change(Job, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /jobs/:id" do
    let!(:job) { create(:job) }

    context "with valid parameters" do
      let(:valid_params) do
        {
          job: {
            title: "Senior Software Engineer"
          }
        }
      end

      it "updates the job" do
        patch "/jobs/#{job.id}", params: valid_params

        expect(response).to have_http_status(:ok)
        expect(job.reload.title).to eq("Senior Software Engineer")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          job: {
            title: nil
          }
        }
      end

      it "does not update the job" do
        original_title = job.title

        patch "/jobs/#{job.id}", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(job.reload.title).to eq(original_title)
      end
    end

    it "returns 404 when the job does not exist" do
      patch "/jobs/999999", params: {
        job: { title: "Senior Software Engineer" }
      }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /jobs/:id" do
    it "deletes the job" do
      job = create(:job)

      expect do
        delete "/jobs/#{job.id}"
      end.to change(Job, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns 404 when the job does not exist" do
      delete "/jobs/999999"

      expect(response).to have_http_status(:not_found)
    end
  end
end
