class Hasher
  class << self

    def get_domain_instance(domain)
      local_variable_name = "@@asari_domain_#{domain}".to_sym

      if self.class_variable_defined?(local_variable_name)
        self.class_variable_get(local_variable_name)
      else
        self.class_variable_set(local_variable_name, Asari.new(ActiveAsari.asari_domain_name(domain)))
      end
    end

    def create_active_asari_hash(domain, hash)
      final_hash = {}
      active_asari_index_array = ACTIVE_ASARI_CONFIG[domain].symbolize_keys.keys
      active_asari_index_array.each do |key, value|
        final_hash[key] = hash[key]
      end
      final_hash[:active_asari_id] = hash[:active_asari_id]
      final_hash
    end

    def add_to_index(domain, hash)
      domain_instance = get_domain_instance(domain)
      asari_hash = create_active_asari_hash domain, hash
      domain_instance.add_item asari_hash[:active_asari_id], asari_hash
    end

  end
end
