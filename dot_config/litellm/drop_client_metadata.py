from litellm.integrations.custom_logger import CustomLogger


class DropClientMetadata(CustomLogger):
    async def async_pre_call_hook(self, user_api_key_dict, cache, data, call_type):
        data.pop("client_metadata", None)
        return data


proxy_handler_instance = DropClientMetadata()
