require "./ServiciosContacto"
require "./Contacto"

class App



    def Run

        @sc = ServiciosContacto.new

        salir = false

        while !salir do
            system('cls')
            puts '#' * 128
            puts ' Agenda digital CLI 2022 - Menu principal '
            puts '=' * 128
            puts ''
            puts ' L - Listar Contactos'
            puts ' B - Buscar Contacto'
            puts ' D - Detalle contacto'
            puts ' A - Alta contacto'
            puts ' M - Modificar contacto'
            puts ' E - Eliminar contacto'
            puts ''
            puts ' S - Salir'
            puts ''
            puts '=' * 128
            print ' Elija una opcion: '
            opcion = gets.chomp
            case opcion
                when 'l', 'L' then @sc.ListarContactos
                when 'b', 'B' then @sc.BuscarContactos
                when 'd', 'D' then @sc.DetalleContacto
                when 'a', 'A' then @sc.AltaContacto
                when 'm', 'M' then @sc.ModificarContacto
                when 'e', 'E' then @sc.EliminarContacto
                when 's', 'S' then
                    salir = true
                    puts ''
                else
                    puts ''
                    puts ' Intentelo nuevamente...'
                    puts ''
                    print ' '
                    system('pause')
                    puts ''
            end
        end
        puts ' Saliendo...'
        puts ''
        puts '#' * 128
    end

end

app = App.new
app.Run()
