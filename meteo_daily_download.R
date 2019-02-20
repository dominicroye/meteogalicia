
import_meteo_daily <- function(idest,idpar,date_from,date_to){
  
  url_base <- "http://servizos.meteogalicia.es/rss/observacion/datosDiariosEstacionsMeteo.action?"
  
  url <- paste(url_base,"idEst=",paste(idest,collapse = ","),"&idParam=",paste(idpar,collapse=","),"&dataIni=",date_from,"&dataFin=",date_to,sep="")
  
  data <- jsonlite::fromJSON(txt=url)[[1]]
  
  df <- dplyr::bind_rows(data$listaEstacions)%>%tidyr::unnest()
  
  if(length(data)!=0){
    
    df[,"date"] <- as.Date(data$data)
    
    df[df$valor==-9999,"valor"] <- NA
    
    return(df)
  }else{
    
    return(NA)
    
  }
  
}

