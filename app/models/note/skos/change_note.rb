# encoding: UTF-8

# Copyright 2011 innoQ Deutschland GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Note::SKOS::ChangeNote < Note::SKOS::Base

  self.rdf_predicate = 'changeNote'

  def self.edit_partial_name(obj)
    "partials/note/skos/edit_change_note"
  end

  def build_rdf(document, subject)
    subject.send(self.rdf_namespace).build_predicate(self.rdf_predicate) do |blank_node|
      blank_node.Rdfs::comment(self.value, :lang => self.language || nil) if self.value
      self.annotations.each do |annotation|
        if (IqRdf::Namespace.find_namespace_class(annotation.namespace))
          blank_node.send(annotation.namespace.camelcase).send(annotation.predicate, annotation.value)
        else
          raise "Note::SKOS::ChangeNote#build_rdf: couldn't find Namespace '#{annotation.namespace}'."
        end
      end
    end
  end

end
