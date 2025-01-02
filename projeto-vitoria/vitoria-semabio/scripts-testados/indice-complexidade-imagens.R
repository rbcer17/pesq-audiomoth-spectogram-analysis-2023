## importando a lista de jpg e criando um dataframe com a img_complexity dos jpgs
rm(list=ls())

install.packages("imagefluency")
library("imagefluency")

jpeg_names <- list.files(pattern = "*.jpg")
jpeg_names

img_complex_list <- lapply(jpeg_names, img_complexity)

# List -> Data frame 
dataframe_img = data.frame(unlist(jpeg_names),unlist(img_complex_list))

names(dataframe_img) = c("nome_JPEG","indice") #renomeando
dataframe_img['nome_JPEG'] <- gsub("\\..*","",dataframe_img$nome_JPEG) # Removendo .JPG
dataframe_img


























