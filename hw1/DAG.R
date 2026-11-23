library(dagitty)

dag <- dagitty(" dag{
               age -> alcohol
               age -> speeding
               age -> ksi
               night -> alcohol
               night -> speeding
               night -> ksi
               alcohol -> ksi
               alcohol -> seat_belt
               alcohol -> speeding
               alcohol -> blood_test
               seat_belt -> ksi
               speeding -> ksi
               ksi -> blood_test
}")

plot(dag)

# Find what to include for the TOTAL effect of alcohol on ksi
adjustmentSets(dag, exposure = "alcohol", outcome = "ksi", effect = "total")
