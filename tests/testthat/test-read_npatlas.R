test_that("read_npatlas() works", {
  expect_equal(class(npatlas), c("data.table", "data.frame"))
  expect_gt(nrow(npatlas), 100)
  
})


cols <- c(
  'NPAID',
  'Names',
  'Molecular Formula',
  'Accurate Mass',
  'Molecular Weight',
  'SMILES',
  'InChIKey',
  'InChI',
  'Origin Type',
  'Genus',
  'Origin Species',
  'Isolation Reference Citation',
  'Isolation Reference DOI',
  'Reassignments',
  'Reassignments DOIs',
  'Synthesis',
  'Synthesis DOIs',
  'NPA URL'
)


test_that("read_npatlas() had  at least expected column headers", {
  expect_true(all(cols %in% colnames(npatlas)))

})
