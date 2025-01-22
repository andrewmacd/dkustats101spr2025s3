library(dplyr)


shanghai.house.price <- read.csv("homeworks/Unit 2 homework/shanghai.house.price.csv")
shanghai.house.price.raw <- read.csv("homeworks/Unit 2 homework/shanghai.house.price.raw.csv")

shanghai.house.price.unique <- shanghai.house.price %>% 
  distinct()

shanghai.house.price.raw.unique <- shanghai.house.price.raw %>% 
  distinct() %>% 
  mutate(价格 = gsub("[^0-9.-]", "", 价格)) %>% 
  mutate(居室数 = as.numeric(居室数),
         厅堂数 = as.numeric(厅堂数),
         卫生间数 = as.numeric(卫生间数),
         价格 = as.numeric(价格))

shanghai.house.price.join <- shanghai.house.price.unique %>% 
  left_join(shanghai.house.price.raw.unique, 
            join_by(标题, 区, 居室数, 厅堂数, 卫生间数, 价格),
            suffix = c("", ".y")) %>% 
  select(c(1:31, 38)) %>% 
  select(-X) %>% 
  relocate(id = X_id) %>% 
  relocate(id, .before=标题) %>% 
  relocate(标题链接, .after=标题) %>% 
  relocate(地址, .after=小区) %>% 
  filter(!is.na(id)) %>% 
  slice_sample(n=300)

sh.raw <- shanghai.house.price.raw.unique %>% 
  slice_head(n=300)

write.csv(shanghai.house.price.join, "sh.house.hw2.csv")
write.csv(sh.raw, "sh.house.raw.sample.hw2.csv")