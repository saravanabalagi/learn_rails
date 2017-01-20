class DishesController < ApplicationController
  before_action :set_dishes

  # GET /dishes/1
  def show
    @dish = @dishes.find(params[:id])
    if @dish.present?
      render json: @dish, include: {
                              dish_variants: {
                                   only: [:id, :price, :image, :icon],
                                   include: {
                                       add_on_type_links: {
                                           only: [:id, :min, :max],
                                           include: { add_on_links: {
                                               only: [:id, :price, :selected],
                                               include: {
                                                   add_on: {
                                                       only: [:id, :name]
                                                   }
                                               }
                                           }, add_on_type: {only: [:id, :name]}}
                                       },
                                      variant: {
                                        only: [:display_name],
                                        include: {
                                            variant_category: {
                                              only: :name,
                                              include: { add_on_type_links: {
                                                  only: [:id, :min, :max],
                                                  include: { add_on_links: {
                                                      only: [:id, :price, :selected],
                                                      include: {
                                                          add_on: {
                                                              only: [:id, :name]
                                                          }
                                                      }
                                                  }, add_on_type: {only: [:id, :name]}}
                                              }}
                                            },
                                            add_on_type_links: {
                                                only: [:id, :min, :max],
                                                include: { add_on_links: {
                                                    only: [:id, :price, :selected],
                                                    include: {
                                                        add_on: {
                                                            only: [:id, :name]
                                                        }
                                                    }
                                                }, add_on_type: {only: [:id, :name]}}
                                            }}
                                      },
                                      food_label: { only: :name}
                                   }
                              },
                              restaurant: {
                                            only: [:id, :name, :logo],
                                            include: { brand: {
                                                only: [:id, :name, :logo]
                                            }}
                              }
                          },
                          only: [:id, :name, :image],
                          methods: [:price]
    else
      render status: :not_found
    end
  end

  private
  def set_dishes
    @dishes = Location.find(request.headers['Location']).packaging_centre.dishes
  end

end
