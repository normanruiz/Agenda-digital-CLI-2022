
class ServiciosContacto

    def AltaContacto
        contacto = Contacto.new
        system('cls')
        puts '#' * 128
        puts ' Agenda digital CLI 2022 - Alta de contacto '
        puts '=' * 128
        puts ''
        puts ' Ingrese los siguientes datos...'
        puts ''
        print ' Nombre: '
        contacto.nombre = gets.chomp.capitalize
        print ' Apellido: '
        contacto.apellido = gets.chomp.capitalize
        print ' Telefono: '
        contacto.telefono = gets.chomp
        print ' Correo: '
        contacto.correo = gets.chomp
        print ' Domicilio: '
        contacto.domicilio = gets.chomp
        puts ''
        confirmacion = nil
        while !(confirmacion == 'Si' or confirmacion == 'No') do
            if !contacto.Verificar
                confirmacion = 'No'
            else
                print ' Confirma el alta(Si/No): '
                confirmacion = gets.chomp
            end
        end
        if confirmacion == 'Si'
            contacto.codigo = GenerarCodigo(contacto.nombre.chars.first + contacto.apellido.chars.first)
            GuardarContacto(contacto)
        end
        puts ''
        puts '=' * 128
        puts ''
        print ' '
        system('pause')
        puts ''
    end

    def GenerarCodigo(paramDos)
        puts ''
        puts ' Generando codigo...'
        serial = nil
        serialFileName = File.join(File.dirname(__FILE__), '/serial.dat')
        if File.exist?(serialFileName)
            serialData = File.new(serialFileName, 'r')
            aux = serialData.read
            serial = (aux[6..15].to_i + 1).to_s.rjust(10,'0')
            serialData.close
        else
            serial = '0000000001'
        end
        return 'CC-' + paramDos + '-' + serial
    end

    def GuardarContacto(contacto)
        puts ''
        puts ' Guardando...'
        contactoFileName = File.join(File.dirname(__FILE__), 'TarjetasContactos', contacto.codigo + '.txt')
        if File.exist?(contactoFileName)
            fileContacto = File.open(contactoFileName, 'r+')
        else
            fileContacto = File.new(contactoFileName, 'w')
        end
        fileContacto.write(contacto.codigo + "\n")
        fileContacto.write(contacto.nombre + "\n")
        fileContacto.write(contacto.apellido + "\n")
        fileContacto.write(contacto.telefono + "\n")
        fileContacto.write(contacto.correo + "\n")
        fileContacto.write(contacto.domicilio + "\n")
        fileContacto.close
        serialFileName = File.join(File.dirname(__FILE__), '/serial.dat')
        serialData = File.new(serialFileName, 'w')
        serialData.write(contacto.codigo)
        serialData.close
        puts ''
        puts ' ' + contacto.codigo
        puts ' ' + contacto.nombre
        puts ' ' + contacto.apellido
        puts ' ' + contacto.telefono
        puts ' ' + contacto.correo
        puts ' ' + contacto.domicilio
        puts ''


        lineas = Array.new
        flag = false

        listFileName = File.join(File.dirname(__FILE__), '/list.dat')

        if File.exist?(listFileName)
            listData = File.open(listFileName, 'r+')
            until listData.eof?
                linea = listData.gets
                if linea.include? contacto.codigo
                    lineas.push(contacto.codigo + '; ' + contacto.nombre + '; ' + contacto.apellido)
                    flag = true
                else
                    lineas.push(linea)
                end
            end
        else
            listData = File.new(listFileName, 'w')
        end

        if !flag
            lineas.push(contacto.codigo + '; ' + contacto.nombre + '; ' + contacto.apellido)
        end

        listData.rewind

        lineas.each do |linea|
            listData.puts(linea)
        end
        listData.close

        puts ' Contacto guardado exitosamente...'
        puts ''
    end

    def ListarContactos
        system('cls')
        puts '#' * 128
        puts ' Agenda digital CLI 2022 - Listado de contactos '
        puts '=' * 128
        puts ''
        listFileName = File.join(File.dirname(__FILE__), '/list.dat')
        if File.exist?(listFileName)
            listData = File.open(listFileName, 'r')
            until listData.eof?
                system('cls')
                puts '#' * 128
                puts ' Agenda digital CLI 2022 - Listado de contactos '
                puts '=' * 128
                puts ''
                10.times do
                    contacto = listData.readline
                    puts ' ' +  contacto
                    if listData.eof?
                        puts ''
                        puts ' No se encontraron mas contactos cargados...'
                        puts ''
                        puts '=' * 128
                        break
                    end
                end
                puts ''
                print ' '
                system('pause')
                puts ''
            end
            listData.close
        else
            system('cls')
            puts '#' * 128
            puts ' Agenda digital CLI 2022 - Listado de contactos '
            puts '=' * 128
            puts ''
            puts ' No se encontraron contactos cargados...'
            puts ''
            puts '=' * 128
            puts ''
            print ' '
            system('pause')
            puts ''
        end

    end

    def DetalleContacto
        system('cls')
        puts '#' * 128
        puts ' Agenda digital CLI 2022 - Detalle de contacto '
        puts '=' * 128
        puts ''
        print ' Ingrese el codigo de contacto: '
        codigo = gets.chomp
        contactoFileName = File.join(File.dirname(__FILE__), 'TarjetasContactos') + '/' + codigo + '.txt'
        if File.exist?(contactoFileName)
            contacto = LeerContacto(contactoFileName)
            puts ''
            puts '=' * 128
            puts ''
            puts ' Codigo: ' + contacto.codigo
            puts ' Nombre: ' + contacto.nombre
            puts ' Apellido: ' + contacto.apellido
            puts ' Telefono: ' + contacto.telefono
            puts ' Correo: ' + contacto.correo
            puts ' Domicilio: ' + contacto.domicilio
            puts ''
            puts '=' * 128
            puts ''
            print ' '
            system('pause')
            puts ''
        else
            puts ''
            puts ' Codigo incorrecto o inexistente...'
            puts ''
            print ' '
            system('pause')
            puts ''
        end

    end

    def LeerContacto(file)
        contacto = Contacto.new
        fileContacto = File.open(file, 'r')
        contacto.codigo = fileContacto.readline.chomp
        contacto.nombre = fileContacto.readline.chomp
        contacto.apellido = fileContacto.readline.chomp
        contacto.telefono = fileContacto.readline.chomp
        contacto.correo = fileContacto.readline.chomp
        contacto.domicilio = fileContacto.readline.chomp
        fileContacto.close
        return contacto
    end

    def EliminarContacto
        system('cls')
        puts '#' * 128
        puts ' Agenda digital CLI 2022 - Eliminar contacto'
        puts '=' * 128
        puts ''
        print ' Ingrese el codigo de contacto: '
        codigo = gets.chomp
        contactoFileName = File.join(File.dirname(__FILE__), 'TarjetasContactos', (codigo + '.txt'))
        if File.exist?(contactoFileName)
            puts ''
            puts '=' * 128
            puts ''
            puts ' Eliminando ' + codigo + ' ...'
            File.delete(contactoFileName)
            BorrarRegistro(codigo)
            puts ''
            puts ' Operacion completada exitosamente...'
            puts ''
            puts '=' * 128
            puts ''
            print ' '
            system('pause')
            puts ''
        else
            puts ''
            puts ' Codigo incorrecto o inexistente...'
            puts ''
            puts '=' * 128
            puts ''
            print ' '
            system('pause')
            puts ''
        end
    end

    def BorrarRegistro(codigo)

        listFileName = File.join(File.dirname(__FILE__), '/list.dat')
        listData = File.open(listFileName, 'r+')

        lineas = Array.new
        truncar = 0
        flag = false

        until listData.eof?
            lineas.push(listData.gets)
        end

        listData.rewind

        lineas.each do |linea|
            if linea.include? codigo
                flag = true
                next
            end
            listData.write(linea)
            truncar = listData.pos
        end
        listData.close
        File.truncate(listData, truncar) if flag
    end

    def ModificarContacto
        system('cls')
        puts '#' * 128
        puts ' Agenda digital CLI 2022 - Editar contacto'
        puts '=' * 128
        puts ''
        print ' Ingrese el codigo de contacto: '
        codigo = gets.chomp
        contactoFileName = File.join(File.dirname(__FILE__), 'TarjetasContactos', (codigo + '.txt'))
        if File.exist?(contactoFileName)
            puts ''
            puts '=' * 128
            puts ''
            puts ' Editando ' + codigo + ' ...'
            contacto = LeerContacto(contactoFileName)
            CargarDatos(contacto)
            GuardarContacto(contacto)
            puts ''
            puts ' Operacion completada exitosamente...'
            puts ''
            puts '=' * 128
            puts ''
            print ' '
            system('pause')
            puts ''
        else
            puts ''
            puts ' Codigo incorrecto o inexistente...'
            puts ''
            puts '=' * 128
            puts ''
            print ' '
            system('pause')
            puts ''
        end

    end

    def CargarDatos(contacto)
        puts ''
        puts ' Ingrese los siguientes datos...'
        puts ''
        print " Nombre(#{contacto.nombre.chomp}): "
        nombre = gets.chomp.capitalize
        contacto.nombre = nombre if nombre.length > 0
        print " Apellido(#{contacto.apellido.chomp}): "
        apellido = gets.chomp.capitalize
        contacto.apellido = apellido if apellido.length > 0
        print " Telefono(#{contacto.telefono.chomp}): "
        telefono = gets.chomp
        contacto.telefono = telefono if telefono.length > 0
        print " Correo(#{contacto.correo.chomp}): "
        correo = gets.chomp
        contacto.correo = correo if correo.length > 0
        print " Domicilio(#{contacto.domicilio.chomp}): "
        domicilio = gets.chomp
        contacto.domicilio = domicilio if domicilio.length > 0
        puts ''
        confirmacion = nil
        while !(confirmacion == 'Si' or confirmacion == 'No') do
            print ' Confirma el alta(Si/No): '
            if !contacto.Verificar
                confirmacion = 'No'
            else
                confirmacion = gets.chomp
            end
        end
    end

    def BuscarContactos
        system('cls')
        puts '#' * 128
        puts ' Agenda digital CLI 2022 - Buscar contactos '
        puts '=' * 128
        puts ''
        print ' Ingrese el patron de busqueda: '
        patron = gets.chomp

        listFileName = File.join(File.dirname(__FILE__), '/list.dat')
        if File.exist?(listFileName)
            listData = File.open(listFileName, 'r')
            until listData.eof?
                system('cls')
                puts '#' * 128
                puts ' Agenda digital CLI 2022 - Buscar contactos '
                puts '=' * 128
                puts ''
                10.times do
                    contacto = listData.readline
                    if contacto.include? patron
                        puts ' ' +  contacto
                    end
                    if listData.eof?
                        puts ''
                        puts ' No se encontraron mas contactos cargados...'
                        puts ''
                        puts '=' * 128
                        break
                    end
                end
                puts ''
                print ' '
                system('pause')
                puts ''
            end
            listData.close
        else
            system('cls')
            puts '#' * 128
            puts ' Agenda digital CLI 2022 - Buscar contactos '
            puts '=' * 128
            puts ''
            puts ' No se encontraron contactos cargados...'
            puts ''
            puts '=' * 128
            puts ''
            print ' '
            system('pause')
            puts ''
        end

    end

end
