#==============================================================================#
# Autor(es): Eduard Martinez
# Colaboradores: 
# Fecha creacion: 17/03/2019
# Fecha modificacion: 17/03/2021
# Version de R: 4.0.3.
#==============================================================================#

# intial configuration
rm(list = ls()) # limpia el entorno de R
pacman::p_load(tidyverse,data.table,readxl) # cargar y/o instalar paquetes a usar

#----------------------------------#
# Importar archivos usando un loop #
#----------------------------------#

# crear vector con ruta de objetos a cargar
list.files(path = "data/input" , full.names = T)
files = list.files(path = "data/input" , full.names = T)
  
# lista para almacenar bases de datos
lista_data = list()
lista_data

# Loop
conteo = 1 # Para contar numero iterraciones
for (i in files){
     lista_data[[conteo]] = read_excel(path = i)
     conteo = conteo + 1
}

# exportar lista
saveRDS(lista_data,"data/output/lista siedco.rds")

#----------------------------------#
# Importar archivos usando un loop #
#----------------------------------#

# Importar archivo "lista siedco.rds" de data/output
ldata = readRDS("data/output/lista siedco.rds")

# Verificar visualmente los datos
df1 = ldata[[1]]  
df10 = ldata[[10]]  

# Limpiar una base de datos
df_i = ldata[[4]]
df_i = subset(df_i,is.na(...2)==F) # elimino observaciones no relevantes
colnames(df_i) = df_i[1,] %>% as.character() # Cambiar nombres
df_i = df_i[-1,]

# Generalizar el paso anterior en una funcion
f_clean = function(i){
          df_i = ldata[[i]]
          df_i = subset(df_i,is.na(...2)==F) # elimino observaciones no relevantes
          colnames(df_i) = df_i[1,] %>% as.character() # Cambiar nombres
          df_i = df_i[-1,]  
return(df_i)
}

# aplicar la funcion
data = lapply(1:14, function(z) f_clean(i = z))

# veamos los elementos de la lista
dc1 = data[[1]]  
dc10 = data[[10]]  

# apliar en un dataframe
dataframe = rbindlist(l = data,use.names = ,fill = T)





