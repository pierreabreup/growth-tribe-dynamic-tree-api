class DownloadRandomTreeHerokuappWorker
  include Sidekiq::Worker

  def perform
    randon_tree = Faraday.get Settings.herokuapp.randon_tree.url

    return if randon_tree.status != 200

    tree = Tree.create!(json_data: randon_tree.body)
    CreateTreeNodesWorker.perform_async(tree.id)
  end
end
