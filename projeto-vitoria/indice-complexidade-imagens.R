## importando a lista de jpg e criando um dataframe com a img_complexity dos jpgs

install.packages("imagefluency")
library("imagefluency")

jpeg_names <- list.files(pattern = "*.jpg")     
jpeg_names
img_complex_list <- lapply(jpeg_names, img_complexity)

## List --> Data frame 

indice_complexidade = data.frame(unlist(jpeg_names),unlist(img_complex_list))

#to name the columns we use names() function
names(indice_complexidade) = c("nomeimagem","indice")




















