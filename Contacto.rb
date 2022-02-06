class Contacto

    attr_accessor :codigo
    attr_accessor :nombre
    attr_accessor :apellido
    attr_accessor :telefono
    attr_accessor :correo
    attr_accessor :domicilio

    def Verificar
        if @nombre.length > 0 and @apellido.length > 0 and @telefono.length > 0 and @correo.length > 0 and @domicilio.length > 0
            return true
        else
            return false
        end
    end

end
