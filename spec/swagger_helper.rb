require 'rails_helper'

RSpec.configure do |config| # rubocop:disable Metrics/BlockLength
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Tesla Test-Drive',
        version: 'v1'
      },
      paths: {
        '/api/users': {
          get: {
            summary: 'List all users',
            tags: ['Users'],
            produces: ['application/json'],
            responses: {
              '200': {
                description: 'List of users',
                content: {
                  'application/json': {
                    schema: {
                      type: :array,
                      items: {
                        type: :object,
                        properties: {
                          id: { type: :integer },
                          username: { type: :string },
                          email: { type: :string }
                        },
                        required: %w[id username email]
                      }
                    }
                  }
                }
              }
            }
          },
          post: {
            summary: 'Create a new user',
            tags: ['Users'],
            consumes: ['application/json'],
            produces: ['application/json'],
            parameters: [
              {
                in: :body,
                name: :user,
                schema: {
                  type: :object,
                  properties: {
                    user: {
                      properties: {
                        username: { type: :string },
                        email: { type: :string },
                        password: { type: :string }
                      }
                    }
                  },
                  required: %w[username email password]
                }
              }
            ],
            responses: {
              '201': {
                description: 'User created',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        username: { type: :string },
                        email: { type: :string }
                      },
                      required: %w[id username email]
                    }
                  }
                }
              },
              '422': {
                description: 'Invalid user data',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        error: { type: :array, items: { type: :string } }
                      },
                      required: ['error']
                    }
                  }
                }
              }
            }
          }
        },
        '/api/users/{id}': {
          get: {
            summary: 'Retrieve a user by ID',
            tags: ['Users'],
            produces: ['application/json'],
            parameters: [
              {
                name: 'id',
                in: 'path',
                type: :integer,
                description: 'ID of user',
                required: true
              }
            ],
            responses: {
              '200': {
                description: 'User found',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        username: { type: :string },
                        email: { type: :string }
                      },
                      required: %w[id username email]
                    }
                  }
                }
              },
              '404': {
                description: 'User not found'
              }
            }
          }
        },
        '/api/users/current': {
          get: {
            summary: 'Retrieve the current user',
            tags: ['Users'],
            produces: ['application/json'],
            security: [
              {
                BearerAuth: []
              }
            ],
            responses: {
              '200': {
                description: 'Current user',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        username: { type: :string },
                        email: { type: :string }
                      },
                      required: %w[id username email]
                    }
                  }
                }
              },
              '401': {
                description: 'Not logged in',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        error: { type: :string }
                      },
                      required: ['error']
                    }
                  }
                }
              }
            }
          }
        },
        '/api/sessions': {
          post: {
            summary: 'Create a new session',
            tags: ['Sessions'],
            consumes: ['application/json'],
            produces: ['application/json'],
            parameters: [
              {
                in: :body,
                name: :user,
                schema: {
                  type: :object,
                  properties: {
                    name: { type: :string },
                    email: { type: :string },
                    password: { type: :string }
                  },
                  required: %w[name email password]
                }
              }
            ],
            responses: {
              '200': {
                description: 'Session created',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        success: { type: :boolean },
                        user_id: { type: :integer },
                        message: { type: :string }
                      },
                      required: %w[success user_id message]
                    }
                  }
                }
              },
              '422': {
                description: 'Invalid user data',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        error: { type: :array, items: { type: :string } }
                      },
                      required: ['error']
                    }
                  }
                }
              }
            }
          }
        },
        '/api/tesla_models': {
          get: {
            summary: 'List all Tesla models',
            tags: ['Tesla Models'],
            produces: ['application/json'],
            responses: {
              '200': {
                description: 'List of Tesla models',
                content: {
                  'application/json': {
                    schema: {
                      type: :array,
                      items: {
                        type: :object,
                        properties: {
                          id: { type: :integer },
                          name: { type: :string },
                          description: { type: :string },
                          deposit: { type: :integer },
                          finance_fee: { type: :integer },
                          option_to_purchase_fee: { type: :integer },
                          total_amount_payable: { type: :integer },
                          duration: { type: :integer },
                          removed: { type: :boolean },
                          image_url: { type: :string, nullable: true }
                        },
                        required: %w[id name description deposit finance_fee option_to_purchase_fee
                                     total_amount_payable duration removed]
                      }
                    }
                  }
                }
              }
            }
          },
          post: {
            summary: 'Create a new Tesla model',
            tags: ['Tesla Models'],
            consumes: ['application/json'],
            produces: ['application/json'],
            parameters: [
              {
                in: :body,
                name: :tesla_model,
                schema: {
                  type: :object,
                  properties: {
                    name: { type: :string },
                    description: { type: :string },
                    deposit: { type: :integer },
                    finance_fee: { type: :integer },
                    option_to_purchase_fee: { type: :integer },
                    total_amount_payable: { type: :integer },
                    duration: { type: :integer },
                    removed: { type: :boolean }
                  },
                  required: %w[name description deposit finance_fee option_to_purchase_fee
                               total_amount_payable duration removed]
                }
              }
            ],
            responses: {
              '201': {
                description: 'Tesla model created successfully',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        message: { type: :string }
                      },
                      required: ['message']
                    }
                  }
                }
              },
              '422': {
                description: 'Invalid Tesla model data',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        errors: { type: :array, items: { type: :string } }
                      },
                      required: ['errors']
                    }
                  }
                }
              }
            }
          }
        },
        '/api/tesla_models/{id}': {
          get: {
            summary: 'Retrieve a Tesla model by ID',
            tags: ['Tesla Models'],
            produces: ['application/json'],
            parameters: [
              {
                name: 'id',
                in: 'path',
                type: :integer,
                description: 'ID of Tesla model',
                required: true
              }
            ],
            responses: {
              '200': {
                description: 'Tesla model found',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        tesla_model: {
                          type: :object,
                          properties: {
                            id: { type: :integer },
                            name: { type: :string },
                            description: { type: :string },
                            deposit: { type: :integer },
                            finance_fee: { type: :integer },
                            option_to_purchase_fee: { type: :integer },
                            total_amount_payable: { type: :integer },
                            duration: { type: :integer },
                            removed: { type: :boolean }
                          },
                          required: %w[id name description deposit finance_fee option_to_purchase_fee
                                       total_amount_payable duration removed]
                        },
                        image_url: { type: :string, nullable: true }
                      },
                      required: %w[tesla_model image_url]
                    }
                  }
                }
              }
            }
          },
          delete: {
            summary: 'Delete a Tesla model by ID',
            tags: ['Tesla Models'],
            produces: ['application/json'],
            parameters: [
              {
                name: 'id',
                in: 'path',
                type: :integer,
                description: 'ID of Tesla model',
                required: true
              }
            ],
            responses: {
              '200': {
                description: 'Tesla model deleted successfully',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        message: { type: :string }
                      },
                      required: ['message']
                    }
                  }
                }
              }
            }
          }
        },
        '/api/users/{user_id}/reservations': {
          get: {
            summary: 'List all user reservations',
            tags: ['Reservations'],
            produces: ['application/json'],
            parameters: [
              {
                name: 'user_id',
                in: 'path',
                type: :integer,
                description: 'ID of the user',
                required: true
              }
            ],
            responses: {
              '200': {
                description: 'List of user reservations',
                content: {
                  'application/json': {
                    schema: {
                      type: :array,
                      items: {
                        type: :object,
                        properties: {
                          id: { type: :integer },
                          start_time: { type: :string, format: 'date-time' },
                          end_time: { type: :string, format: 'date-time' },
                          city: { type: :string },
                          tesla_model_id: { type: :integer },
                          user_id: { type: :integer }
                        },
                        required: %w[id start_time end_time city tesla_model_id user_id]
                      }
                    }
                  }
                }
              }
            }
          },
          post: {
            summary: 'Create a new reservation',
            tags: ['Reservations'],
            consumes: ['application/json'],
            produces: ['application/json'],
            parameters: [
              {
                name: 'user_id',
                in: 'path',
                type: :integer,
                description: 'ID of the user',
                required: true
              },
              {
                in: :body,
                name: :reservation,
                schema: {
                  type: :object,
                  properties: {
                    start_time: { type: :string, format: 'date-time' },
                    end_time: { type: :string, format: 'date-time' },
                    city: { type: :string }
                  },
                  required: %w[start_time end_time city]
                }
              }
            ],
            responses: {
              '201': {
                description: 'Reservation created successfully',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        success: { type: :boolean },
                        reservation_id: { type: :integer }
                      },
                      required: %w[success reservation_id]
                    }
                  }
                }
              },
              '422': {
                description: 'Invalid reservation data',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        error: { type: :string }
                      },
                      required: ['error']
                    }
                  }
                }
              }
            }
          }
        },
        '/api/users/{user_id}/reservations/{id}': {
          get: {
            summary: 'Retrieve a reservation by ID',
            tags: ['Reservations'],
            produces: ['application/json'],
            parameters: [
              {
                name: 'user_id',
                in: 'path',
                type: :integer,
                description: 'ID of the user',
                required: true
              },
              {
                name: 'id',
                in: 'path',
                type: :integer,
                description: 'ID of the reservation',
                required: true
              }
            ],
            responses: {
              '200': {
                description: 'Reservation details',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        start_time: { type: :string, format: 'date-time' },
                        end_time: { type: :string, format: 'date-time' },
                        city: { type: :string },
                        tesla_model_id: { type: :integer },
                        user_id: { type: :integer }
                      },
                      required: %w[id start_time end_time city tesla_model_id user_id]
                    }
                  }
                }
              }
            }
          },
          put: {
            summary: 'Update a reservation by ID',
            tags: ['Reservations'],
            consumes: ['application/json'],
            produces: ['application/json'],
            parameters: [
              {
                name: 'user_id',
                in: 'path',
                type: :integer,
                description: 'ID of the user',
                required: true
              },
              {
                name: 'id',
                in: 'path',
                type: :integer,
                description: 'ID of the reservation',
                required: true
              },
              {
                in: :body,
                name: :reservation,
                schema: {
                  type: :object,
                  properties: {
                    start_time: { type: :string, format: 'date-time' },
                    end_time: { type: :string, format: 'date-time' },
                    city: { type: :string }
                  },
                  required: %w[start_time end_time city]
                }
              }
            ],
            responses: {
              '200': {
                description: 'Reservation updated successfully',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        success: { type: :boolean },
                        reservation: {
                          type: :object,
                          properties: {
                            id: { type: :integer },
                            start_time: { type: :string, format: 'date-time' },
                            end_time: { type: :string, format: 'date-time' },
                            city: { type: :string },
                            tesla_model_id: { type: :integer },
                            user_id: { type: :integer }
                          },
                          required: %w[id start_time end_time city tesla_model_id user_id]
                        }
                      },
                      required: %w[success reservation]
                    }
                  }
                }
              },
              '422': {
                description: 'Invalid reservation data',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        error: { type: :string }
                      },
                      required: ['error']
                    }
                  }
                }
              }
            }
          },
          delete: {
            summary: 'Delete a reservation by ID',
            tags: ['Reservations'],
            produces: ['application/json'],
            parameters: [
              {
                name: 'user_id',
                in: 'path',
                type: :integer,
                description: 'ID of the user',
                required: true
              },
              {
                name: 'id',
                in: 'path',
                type: :integer,
                description: 'ID of the reservation',
                required: true
              }
            ],
            responses: {
              '200': {
                description: 'Reservation deleted successfully',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        success: { type: :boolean },
                        message: { type: :string }
                      },
                      required: %w[success message]
                    }
                  }
                }
              }
            }
          }
        }
      },
      servers: [
        {
          url: 'http://127.0.0.1:3000',
          variables: {
            defaultHost: {
              default: 'http://127.0.0.1:3000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
