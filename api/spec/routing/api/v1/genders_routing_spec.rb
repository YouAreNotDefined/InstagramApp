require "rails_helper"

RSpec.describe Api::V1::GendersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/genders").to route_to("api/v1/genders#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/genders/1").to route_to("api/v1/genders#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/genders").to route_to("api/v1/genders#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/genders/1").to route_to("api/v1/genders#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/genders/1").to route_to("api/v1/genders#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/genders/1").to route_to("api/v1/genders#destroy", id: "1")
    end
  end
end
