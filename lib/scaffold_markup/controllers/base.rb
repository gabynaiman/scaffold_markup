module ScaffoldMarkup
  module Controllers
    module Base
      def self.included(base)
        base.helper_method [:resource_class, :controller_namespace]
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

      def resource_class
        @resource_class ||= controller_name.classify.constantize
      end

      def controller_namespace
        @controller_namespace ||= self.class.name.split('::')[0..-2].map(&:underscore).join('_') unless self.class.name.split('::')[0..-2].empty?
      end

    end
  end
end