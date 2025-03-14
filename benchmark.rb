Benchmark.measure {
  publications = Publication.all.load
  has_image = PublicationImage.select(:publication_id, :id).distinct(:publication_id).load.map{|t| [t.publication_id, t.id] }.to_h
  result = publications.map{ |p| [p.id, {publication: p, image: has_image[p.id]}] }
  result
}.real

Benchmark.measure {
  Publication.all.eager_load(:promotion, :publication_images, :cities).load
}.real

Benchmark.measure {
  Publication.all.eager_load(:promotion, :publication_images).load
}.real

Benchmark.measure {
  Publication.all.eager_load(:publication_images).load
}.real

Benchmark.measure {
  PublicationImage.joins("INNER JOIN publications ON publications.id = 1")
}.real

Benchmark.measure {
  publication = Publication.all.find(1)
  publication_image = publication.cover_image
  publication_image
}.real

Benchmark.measure {
  publication = Publication.all.eager_load(:publication_images).load.find(1)
  publication_image = publication.cover_image
  publication_image
}.real

Benchmark.measure {
  publication = Publication.all.eager_load(:publication_images).load.where.not(publication_images: { id: nil }).distinct.find(1)
  publication_image = publication.cover_image
  publication_image
}.real

Benchmark.measure {
  Manager.all.eager_load(:company_managers).load
}.real

Benchmark.measure {
  Manager.order("created_at DESC")
}.real

Benchmark.measure {
  publication = Publication.all.find(1)
  publication_image = publication.cover_image

  PublicationImageSerializer.new(publication_image)
}.real

Benchmark.measure {
  publication = Publication.all.find(1)
  publication_image = publication.cover_image

  PublicationImagePankoSerializer.new.serialize(publication_image)
}.real
