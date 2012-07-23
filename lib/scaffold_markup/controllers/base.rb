module ScaffoldMarkup
  module Controllers
    module Base
      attr_reader :resource_class

      def self.included(base)
        base.before_filter :identify_resource
      end

      def index
        @collection = resource_class.page(params[:page])
      end

      def show
        @model = resource_class.find(params[:id])
      end

      def new
        @model = resource_class.new
      end

      def edit
        @model = resource_class.find(params[:id])
      end

      def create
        @model = resource_class.new(params[resource_class.model_name.underscore])
        if @model.save
          flash_message = "#{resource_class.model_name.human} successfully created"
          if params[:save_and_new]
            flash[:success] = flash_message
            redirect_to :action => :new
          else
            flash.now[:success] = flash_message
            render :show
          end
        else
          render :new
        end
      end

      def update
        @model = resource_class.find(params[:id])
        if @model.update_attributes(params[resource_class.model_name.underscore])
          flash.now[:success] = "#{resource_class.model_name.human} successfully updated"
          render :show
        else
          render :edit
        end
      end

      def destroy
        @model = resource_class.find(params[:id])
        if @model.destroy
          flash[:warning] = "#{resource_class.model_name.human} successfully removed"
        else
          flash[:danger] = "#{resource_class.model_name.human} could not be deleted"
        end
        redirect_to :action => :index
      end

      private

      def identify_resource
        @resource_class = params[:controller].classify.constantize
      end

    end
  end
end