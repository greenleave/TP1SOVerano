#############################################################################################
# PROGRAM-ID.  ejercicio7.ps1					                                            #
# OBJETIVO DEL PROGRAMA: Analiza la estructura de una matriz y determina el tipo al         #
# que corresponde.                                                                          #
# TIPO DE PROGRAMA: .ps1                                                                    #
# ALUMNOS :                                                                                 #                                                                              
#           -Bogado, Sebastian                                                              #
#           -Rey, Juan Cruz                                                                 #
# EjemploEj.:                                                                               #
# C:\PS> .\ejercicio4.ps1 C:/miarchivo.txt                                                  #
#############################################################################################

<#
.SYNOPSIS 
Analiza la estructura de una matriz y determina el tipo al que corresponde.
.DESCRIPTION
Lee y analiza la estructura de una Matriz cargarda en un Archivo separada por un caracter que llega de parametro y filas por salto de linea.
.PARAMETER Path
Especifica el path del archivo que contiene la matriz.
.PARAMETER delim
Especifica el caracter separador de las columnas.
.EXAMPLE
c:\PS> ./ejercicio7.ps1 -path C:/matriz.txt -delim '&'
.EXAMPLE
c:\PS> ./ejercicio7.ps1 -path C:/matriz.txt '&'
    
.EXAMPLE
c:\PS> ./ejercicio7.ps1 C:/matriz.txt '&'    
            
#>

Param
(
    [parameter(Position=0, Mandatory=$true)]
    [String]
    [ValidateNotNullOrEmpty()]
    $PathMatriz,

    [parameter(Position=1, Mandatory=$true)]
    [String]
    [ValidateLength(4,20)]
    $Operacion
)

function abrirYCargarArchivo(){
    Write-Debug "LLega a abrir el archivo"
    $delimitadorFilas=";;"
    $delimitadorColumnas=";"
    if( Test-Path $PathMatriz ){
        if(Test-Path $PathMatriz -PathType Container){
            Write-Error "El path especificado debe pertenecer a un archivo y no a un directorio";
            exit;
        }
        $file = Get-Content $PathMatriz
        switch($file.count){
            1{
                Write-Host "llega al switch del archivo"
                $arrayAux=$file.Split($delimitadorFilas)
                [string [][]]$matriz= new String[][];
                echo $arrayAux.Count

                $cantidadColumnas=0;
                $contColumnas=0;
                $cantidadFilas=0;

                foreach ($elemento in $arrayAux){
                    ##La cantidad de letras del elemento es distinta de cero
                    ##Tengo agregarlo a la matriz y sumar 1 a la cantidad de columnas
                    if($elemento.Length -ne 0){
                        $matriz[$cantidadFilas][$contColumnas]=$elemento;
                        $contColumnas++;
                    }
                    else{

                        if( $contColumnas -eq 0 ){
                            Write-Error "La matriz no puede contener filas vacias"
                            exit
                        }
                        else{
                            if( $cantidadColumnas -eq 0 ){
                                $cantidadColumnas=$contColumnas
                            }
                            if( $cantidadColumnas -ne $contColumnas ){
                                Write-Error "La fila $cantidadFilas es desigual en la cantidad de columnas. Las columnas anteriores eran de $cantidadColumnas elementos y esta contiene $contColumnas"
                            }
                            $cantidadFilas++
                        }
                    }
                 }
            }
            
            2{
                Write-Host "Solo dos parametros"
            }
            default{
                Write-Error "Error el archivo debe contener dos o una linea."
            }
        }

    }
    else{
        Write-Error "El path no existe"
    }
}

function transponerMatriz(){
    Write-Host "tranponer la matriz"
}

function discriminarOperacionBinaria(){
    Write-Host "Aca deberia discriminar e ir por otro switch"
}


Switch($psboundparameters.Count + $args.Count){
    
    #En caso que tenga un parametro o tres funciona y discrimina las funciones#
    2{
        Write-Debug "Entra por que tiene solo un parametro"
        abrirYCargarArchivo
    }

    default{
        Write-Error "Parametros insuficientes"
    }
}
