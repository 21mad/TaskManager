require "rails_helper"

RSpec.describe PublicFoldersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/public_folders").to route_to("public_folders#index")
    end

    it "routes to #new" do
      expect(get: "/public_folders/new").to route_to("public_folders#new")
    end

    it "routes to #show" do
      expect(get: "/public_folders/1").to route_to("public_folders#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/public_folders/1/edit").to route_to("public_folders#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/public_folders").to route_to("public_folders#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/public_folders/1").to route_to("public_folders#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/public_folders/1").to route_to("public_folders#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/public_folders/1").to route_to("public_folders#destroy", id: "1")
    end
  end
end
