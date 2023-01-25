""" 
 This sends a discord notification to a certain channel. 
 This code can be implemented in a lambda to notify upon 
 certain event.

 reference: https://pypi.org/project/discord-webhook/

 author: ashraf minhaj
 mail  : ashraf_minhaj@yahoo.com
"""

""" 
Install discord webhook - 
$ pip install discord-webhook
"""

from discord_webhook import DiscordWebhook, DiscordEmbed

# get the webhook url for certain channel
# In Discord, select the Server, under Text Channels, select Edit Channel (gear icon) 
# Select Integrations > View Webhooks and click New Webhook. Copy the Webhook URL.
# ref: https://docs.netapp.com/us-en/cloudinsights/task_webhook_example_discord.html#:~:text=In%20Discord%2C%20select%20the%20Server,Copy%20the%20Webhook%20URL.
webhook_url = 'https://discord.com/api/webhooks/1qBF7gH08i'

# image url to attach
img_url = 'https://images.unsplash.com/photo-1591497108596-436c1a1a5c8e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'

# notify user
# Finding your Discord ID on the desktop web browser
# In your settings, scroll the left side of your screen and select Advanced under App Settings. 
# Turn on Developer Mode using the toggle button. 
# Return to your settings, select My Account, click on the horizontal dots next to your Discord tag, 
# then click Copy ID. 
# ref: https://www.androidpolice.com/how-to-find-discord-id/#:~:text=Finding%20your%20Discord%20ID%20on%20the%20desktop%20web%20browser&text=In%20your%20settings%2C%20scroll%20the,select%20Advanced%20under%20App%20Settings.&text=Turn%20on%20Developer%20Mode%20using,tag%2C%20then%20click%20Copy%20ID.
user_id = 640432483250208788

# webhook = DiscordWebhook(url=webhook_url, content=f'<@{user_id}>, error found')
webhook = DiscordWebhook(url=webhook_url)

# create embed object for webhook
embed = DiscordEmbed(title='Error Found', description=f'<@{user_id}> Error in line no. 49', color='AA4A44')

# set image
embed.set_image(url=img_url)

# add embed object to webhook
webhook.add_embed(embed)

response = webhook.execute()
print(response)