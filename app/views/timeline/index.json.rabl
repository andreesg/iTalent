collection @all_publications 

attributes :id, :text

child :comments do
	attributes :id, :text
end
