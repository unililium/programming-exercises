
# coding: utf-8

# In[4]:

import collections
Tweet = collections.namedtuple("Tweet", "num date time text")
ClassifiedTweet = collections.namedtuple("ClassifiedTweet", "num sentiment")


# In[5]:

tweet1 = Tweet(1, "09/05/2017", "08:00:00", "I love the new phone by YYY")
tweet2 = Tweet(2, "09/05/2017", "08:35:00", "The new phone by YYY is cool")
tweet3 = Tweet(3, "09/05/2017", "08:03:00", "I heard about X, but...")
tweetsRDD = sc.parallelize([tweet1, tweet2, tweet3])


# In[17]:

def sentiment(s):
    positive = ('love', 'like', 'amazing', 'cool', 'terrific')
    negative = ('hate', 'boring', 'stupid', 'terrible')
    
    words = s.split(' ')
    ngood = len(filter(lambda x : x in positive, words))
    nbad = len(filter(lambda x : x in negative, words))
    
    if ngood > nbad:
        return '+'
    elif ngood < nbad:
        return '-'
    else:
        return '='


# In[24]:

ClassifiedTweetRDD = tweetsRDD.map(lambda x : ClassifiedTweet(x[0], sentiment(x[-1])))


# In[25]:

ClassifiedTweetRDD.collect()


# In[34]:

negtweetRDD = ClassifiedTweetRDD.filter(lambda x : x[1] == '-')


# In[35]:

negtweetRDD.collect()


# In[39]:

idRDD = ClassifiedTweetRDD.map(lambda x : (x[0]))


# In[40]:

idRDD.collect()


# In[ ]:



