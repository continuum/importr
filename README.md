# Importr

This gem adds functionality to data models so that they can import data from
spreadsheets.

## Installation

Add this line to your application's Gemfile:

    gem 'importr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install importr

## Usage

Include the module and declare importers inside a data model class:

    class Employee
      include Importr::Importable

      importer do |c|
        c.column 'First Name', :first_name
        c.column 'Last Name', :last_name
        c.column 'Department', :department do |value|
          Department.find_by(name: value)
        end
      end
    end

Columns are declared, giving the column header expected from the spreadsheet
file, the field to which the column corresponds.  An optional block of code or
lambda expression can be provided to process the value from the spreadsheet
before assigning it to the corresponding field.

### Multiple importers

Multiple importers can be declared for each data model class, by assigning them names:

    class Employee
      include Importr::Importable

      importer :english do |c|
        c.column 'First Name', :first_name
        c.column 'Last Name', :last_name
        c.column 'Department', :department do |value|
          Department.find_by(name: value)
        end
      end

      importer :spanish do |c|
        c.column 'Nombre', :first_name
        c.column 'Apellidos', :last_name
        c.column 'Departamento', :department do |value|
          Department.find_by(name: value)
        end
      end
    end

### Custom code during import

For cases when importing is not limited to merely assigning cell values to
fields, the user can provide a custom block of code where it can work directly
with the spreadsheet row and the model object being generated.

    class Employee
      include Importr::Importable

      importer do |c|
        c.column 'First Name', :first_name
        c.column 'Last Name', :last_name
        c.column 'Department', :department do |value|
          Department.find_by(name: value)
        end

        c.custom do |row, employee|
          # ...
        end
      end
    end

### WebSocket integration

If you need to emit the progress of importation in realtime, like errors validations, you can configure the Importer in an initializer for websocket notification:

    Importr::Config.setup do |config|
      config.web_socket_class  = 'Faye' 
      config.web_socket_method = "publish"
    end

Importr will manage the event publication for errors 
