require "rails_helper"

RSpec.describe "Analyses API", type: :request do
  describe "GET /analyses" do
    it "returns all analyses" do
      analysis1 = create(:analysis)
      analysis2 = create(:analysis)

      get "/analyses"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.length).to eq(2)
      expect(json.map { |analysis| analysis["id"] }).to contain_exactly(
        analysis1.id,
        analysis2.id
      )
    end

    it "returns an empty array when there are no analyses" do
      get "/analyses"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end
  end

  describe "GET /analyses/:id" do
    it "returns the requested analysis" do
      analysis = create(:analysis)

      get "/analyses/#{analysis.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["id"]).to eq(analysis.id)
      expect(json["resume_id"]).to eq(analysis.resume_id)
      expect(json["job_id"]).to eq(analysis.job_id)
      expect(json["match_score"]).to eq(analysis.match_score)
      expect(json["summary"]).to eq(analysis.summary)
    end

    it "returns 404 when the analysis does not exist" do
      get "/analyses/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /analyses" do
    let(:resume) { create(:resume) }
    let(:job) { create(:job) }

    context "with valid parameters" do
      let(:valid_params) do
        {
          analysis: {
            resume_id: resume.id,
            job_id: job.id,
            match_score: 85,
            summary: "Strong match for the position."
          }
        }
      end

      it "creates an analysis" do
        expect do
          post "/analyses", params: valid_params
        end.to change(Analysis, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)

        expect(json["resume_id"]).to eq(resume.id)
        expect(json["job_id"]).to eq(job.id)
        expect(json["match_score"]).to eq(85)
        expect(json["summary"]).to eq("Strong match for the position.")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          analysis: {
            resume_id: resume.id,
            job_id: job.id,
            match_score: nil,
            summary: "Strong match for the position."
          }
        }
      end

      it "does not create an analysis" do
        expect do
          post "/analyses", params: invalid_params
        end.not_to change(Analysis, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /analyses/:id" do
    let!(:analysis) { create(:analysis) }

    context "with valid parameters" do
      let(:valid_params) do
        {
          analysis: {
            match_score: 95,
            summary: "Excellent match for the position."
          }
        }
      end

      it "updates the analysis" do
        patch "/analyses/#{analysis.id}", params: valid_params

        expect(response).to have_http_status(:ok)

        analysis.reload

        expect(analysis.match_score).to eq(95)
        expect(analysis.summary).to eq(
          "Excellent match for the position."
        )
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          analysis: {
            match_score: nil
          }
        }
      end

      it "does not update the analysis" do
        original_score = analysis.match_score

        patch "/analyses/#{analysis.id}", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(analysis.reload.match_score).to eq(original_score)
      end
    end

    it "returns 404 when the analysis does not exist" do
      patch "/analyses/999999", params: {
        analysis: {
          match_score: 95
        }
      }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /analyses/:id" do
    it "deletes the analysis" do
      analysis = create(:analysis)

      expect do
        delete "/analyses/#{analysis.id}"
      end.to change(Analysis, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns 404 when the analysis does not exist" do
      delete "/analyses/999999"

      expect(response).to have_http_status(:not_found)
    end
  end
end
