INSERT INTO "scenario_data" ("data") 
  VALUES (?) 
  ON CONFLICT ("sha_256") 
    DO UPDATE SET "sha_256" = NULL;