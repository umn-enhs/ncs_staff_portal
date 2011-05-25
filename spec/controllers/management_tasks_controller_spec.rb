require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe ManagementTasksController do

  def mock_management_task(stubs={})
    @mock_management_task ||= mock_model(ManagementTask, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all management_tasks as @management_tasks" do
      ManagementTask.stub(:all) { [mock_management_task] }
      get :index
      assigns(:management_tasks).should eq([mock_management_task])
    end
  end

  describe "GET show" do
    it "assigns the requested management_task as @management_task" do
      ManagementTask.stub(:find).with("37") { mock_management_task }
      get :show, :id => "37"
      assigns(:management_task).should be(mock_management_task)
    end
  end

  describe "GET new" do
    it "assigns a new management_task as @management_task" do
      ManagementTask.stub(:new) { mock_management_task }
      get :new
      assigns(:management_task).should be(mock_management_task)
    end
  end

  describe "GET edit" do
    it "assigns the requested management_task as @management_task" do
      ManagementTask.stub(:find).with("37") { mock_management_task }
      get :edit, :id => "37"
      assigns(:management_task).should be(mock_management_task)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created management_task as @management_task" do
        ManagementTask.stub(:new).with({'these' => 'params'}) { mock_management_task(:save => true) }
        post :create, :management_task => {'these' => 'params'}
        assigns(:management_task).should be(mock_management_task)
      end

      it "redirects to the created management_task" do
        ManagementTask.stub(:new) { mock_management_task(:save => true) }
        post :create, :management_task => {}
        response.should redirect_to(management_task_url(mock_management_task))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved management_task as @management_task" do
        ManagementTask.stub(:new).with({'these' => 'params'}) { mock_management_task(:save => false) }
        post :create, :management_task => {'these' => 'params'}
        assigns(:management_task).should be(mock_management_task)
      end

      it "re-renders the 'new' template" do
        ManagementTask.stub(:new) { mock_management_task(:save => false) }
        post :create, :management_task => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested management_task" do
        ManagementTask.stub(:find).with("37") { mock_management_task }
        mock_management_task.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :management_task => {'these' => 'params'}
      end

      it "assigns the requested management_task as @management_task" do
        ManagementTask.stub(:find) { mock_management_task(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:management_task).should be(mock_management_task)
      end

      it "redirects to the management_task" do
        ManagementTask.stub(:find) { mock_management_task(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(management_task_url(mock_management_task))
      end
    end

    describe "with invalid params" do
      it "assigns the management_task as @management_task" do
        ManagementTask.stub(:find) { mock_management_task(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:management_task).should be(mock_management_task)
      end

      it "re-renders the 'edit' template" do
        ManagementTask.stub(:find) { mock_management_task(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested management_task" do
      ManagementTask.stub(:find).with("37") { mock_management_task }
      mock_management_task.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the management_tasks list" do
      ManagementTask.stub(:find) { mock_management_task }
      delete :destroy, :id => "1"
      response.should redirect_to(management_tasks_url)
    end
  end

end