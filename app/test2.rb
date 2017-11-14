HEROKU ones

PerCatPins
irb(main):001:0> percatpins = PersonalCategoryPin.all
D, [2017-11-14T19:30:03.641105 #4] DEBUG -- :   PersonalCategoryPin Load (0.8ms)  SELECT  "personal_category_pins".* FROM "personal_category_pins" LIMIT $1  [["LIMIT", 11]]
=> #<ActiveRecord::Relation [
#<PersonalCategoryPin id: 5, personal_category_id: 3, pin_id: 3, created_at: "2017-11-02 21:29:23", updated_at: "2017-11-02 21:29:23">, 
#<PersonalCategoryPin id: 8, personal_category_id: 14, pin_id: 3, created_at: "2017-11-03 05:19:24", updated_at: "2017-11-03 05:19:24">, 
#<PersonalCategoryPin id: 10, personal_category_id: 14, pin_id: 5, created_at: "2017-11-03 06:21:04", updated_at: "2017-11-03 06:21:04">, 
#<PersonalCategoryPin id: 11, personal_category_id: 6, pin_id: 18, created_at: "2017-11-03 06:21:53", updated_at: "2017-11-03 06:21:53">, 
#<PersonalCategoryPin id: 12, personal_category_id: 6, pin_id: 19, created_at: "2017-11-03 06:22:08", updated_at: "2017-11-03 06:22:08">, 
#<PersonalCategoryPin id: 14, personal_category_id: 5, pin_id: 19, created_at: "2017-11-03 06:22:30", updated_at: "2017-11-03 06:22:30">, 
#<PersonalCategoryPin id: 15, personal_category_id: 3, pin_id: 5, created_at: "2017-11-04 05:43:45", updated_at: "2017-11-04 05:43:45">, 
#<PersonalCategoryPin id: 16, personal_category_id: 13, pin_id: 19, created_at: "2017-11-04 06:19:22", updated_at: "2017-11-04 06:19:22">, 
#<PersonalCategoryPin id: 18, personal_category_id: 19, pin_id: 27, created_at: "2017-11-10 23:14:21", updated_at: "2017-11-10 23:14:21">, 
#<PersonalCategoryPin id: 19, personal_category_id: 3, pin_id: 29, created_at: "2017-11-11 02:19:41", updated_at: "2017-11-11 02:19:41">, ...]>
irb(main):002:0> percatpins


PerCats
=> 
#<ActiveRecord::Relation [
#<PersonalCategory id: 4, user_id: 4, name: "Floral", created_at: "2017-10-15 02:23:27", updated_at: "2017-10-15 02:23:27">, 
#<PersonalCategory id: 8, user_id: 4, name: "Bubbly", created_at: "2017-10-25 04:50:37", updated_at: "2017-10-25 04:50:37">, 
#<PersonalCategory id: 3, user_id: 3, name: "Fruity", created_at: "2017-10-14 16:21:48", updated_at: "2017-11-02 21:30:16">, 
#<PersonalCategory id: 5, user_id: 3, name: "Earthy", created_at: "2017-10-22 18:49:47", updated_at: "2017-11-02 21:30:30">, 
#<PersonalCategory id: 6, user_id: 3, name: "Oaky", created_at: "2017-10-22 19:31:08", updated_at: "2017-11-02 21:30:46">, 
#<PersonalCategory id: 14, user_id: 3, name: "Zesty", created_at: "2017-11-02 21:31:09", updated_at: "2017-11-02 21:31:09">, 
#<PersonalCategory id: 19, user_id: 9, name: "full bodied", created_at: "2017-11-10 23:14:13", updated_at: "2017-11-10 23:14:13">, 
#<PersonalCategory id: 1, user_id: 4, name: "Smooth", created_at: "2017-11-13 00:49:19", updated_at: "2017-11-13 00:49:19">, 
#<PersonalCategory id: 2, user_id: 3, name: "Special Occasion", created_at: "2017-11-14 17:28:49", updated_at: "2017-11-14 17:28:49">, 
#<PersonalCategory id: 7, user_id: 3, name: "Wines to try", created_at: "2017-11-14 17:50:57", updated_at: "2017-11-14 17:50:57">]>

Pins
=> 
#<ActiveRecord::Relation [
#<Pin id: 5, user_id: 3, wine_id: 2, created_at: "2017-10-08 20:40:14", updated_at: "2017-10-08 20:40:14">, 
#<Pin id: 18, user_id: 3, wine_id: 38, created_at: "2017-11-02 17:29:08", updated_at: "2017-11-02 17:29:08">, 
#<Pin id: 19, user_id: 3, wine_id: 35, created_at: "2017-11-02 20:02:37", updated_at: "2017-11-02 20:02:37">, 
#<Pin id: 27, user_id: 9, wine_id: 101, created_at: "2017-11-10 23:13:41", updated_at: "2017-11-10 23:13:41">, 
#<Pin id: 28, user_id: 4, wine_id: 124, created_at: "2017-11-10 23:40:19", updated_at: "2017-11-10 23:40:19">, 
#<Pin id: 29, user_id: 3, wine_id: 147, created_at: "2017-11-11 00:46:00", updated_at: "2017-11-11 00:46:00">, 
#<Pin id: 30, user_id: 10, wine_id: 124, created_at: "2017-11-11 02:14:48", updated_at: "2017-11-11 02:14:48">, 
#<Pin id: 3, user_id: 3, wine_id: 1, created_at: "2017-11-14 17:24:59", updated_at: "2017-11-14 17:24:59">, 
#<Pin id: 4, user_id: 3, wine_id: 124, created_at: "2017-11-14 17:25:59", updated_at: "2017-11-14 17:25:59">]>


#===========================

<ActiveRecord::Relation [
#<PersonalCategoryPin id: 3, personal_category_id: 9, pin_id: 5, created_at: "2017-10-25 22:03:08", updated_at: "2017-10-25 22:03:08">, 

#<PersonalCategoryPin id: 5, personal_category_id: 3, pin_id: 3, created_at: "2017-11-02 21:29:23", updated_at: "2017-11-02 21:29:23">, 

#<PersonalCategoryPin id: 8, personal_category_id: 14, pin_id: 3, created_at: "2017-11-03 05:19:24", updated_at: "2017-11-03 05:19:24">, 

#<PersonalCategoryPin id: 10, personal_category_id: 14, pin_id: 5, created_at: "2017-11-03 06:21:04", updated_at: "2017-11-03 06:21:04">, 

#<PersonalCategoryPin id: 11, personal_category_id: 6, pin_id: 18, created_at: "2017-11-03 06:21:53", updated_at: "2017-11-03 06:21:53">, 

#<PersonalCategoryPin id: 12, personal_category_id: 6, pin_id: 19, created_at: "2017-11-03 06:22:08", updated_at: "2017-11-03 06:22:08">, 

#<PersonalCategoryPin id: 14, personal_category_id: 5, pin_id: 19, created_at: "2017-11-03 06:22:30", updated_at: "2017-11-03 06:22:30">, 

#<PersonalCategoryPin id: 15, personal_category_id: 3, pin_id: 5, created_at: "2017-11-04 05:43:45", updated_at: "2017-11-04 05:43:45">, 

#<PersonalCategoryPin id: 16, personal_category_id: 13, pin_id: 19, created_at: "2017-11-04 06:19:22", updated_at: "2017-11-04 06:19:22">, #<PersonalCategoryPin id: 18, personal_category_id: 19, pin_id: 27, created_at: "2017-11-10 23:14:21", updated_at: "2017-11-10 23:14:21">, ...]

--------

<ActiveRecord::Relation [
#<PersonalCategory id: 4, user_id: 4, name: "Floral", created_at: "2017-10-15 02:23:27", updated_at: "2017-10-15 02:23:27">, 

#<PersonalCategory id: 8, user_id: 4, name: "Bubbly", created_at: "2017-10-25 04:50:37", updated_at: "2017-10-25 04:50:37">,

 #<PersonalCategory id: 3, user_id: 3, name: "Fruity", created_at: "2017-10-14 16:21:48", updated_at: "2017-11-02 21:30:16">,

 #<PersonalCategory id: 5, user_id: 3, name: "Earthy", created_at: "2017-10-22 18:49:47", updated_at: "2017-11-02 21:30:30">,

 #<PersonalCategory id: 6, user_id: 3, name: "Oaky", created_at: "2017-10-22 19:31:08", updated_at: "2017-11-02 21:30:46">,

 #<PersonalCategory id: 14, user_id: 3, name: "Zesty", created_at: "2017-11-02 21:31:09", updated_at: "2017-11-02 21:31:09">,

 #<PersonalCategory id: 19, user_id: 9, name: "full bodied", created_at: "2017-11-10 23:14:13", updated_at: "2017-11-10 23:14:13">,

 #<PersonalCategory id: 20, user_id: 3, name: "Special Occasion", created_at: "2017-11-14 17:18:25", updated_at: "2017-11-14 17:18:25">]>
