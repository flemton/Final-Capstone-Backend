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
