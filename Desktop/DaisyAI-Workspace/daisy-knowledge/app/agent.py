# Copyright 2025 Google LLC
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

import datetime
import os
from zoneinfo import ZoneInfo

import google.auth
from google.adk.agents import Agent

_, project_id = google.auth.default()
os.environ.setdefault("GOOGLE_CLOUD_PROJECT", project_id)
os.environ.setdefault("GOOGLE_CLOUD_LOCATION", "global")
os.environ.setdefault("GOOGLE_GENAI_USE_VERTEXAI", "True")


def search_music_industry_knowledge(query: str) -> str:
    """Searches the music industry knowledge base for information about artists, labels, trends, and industry practices.

    Args:
        query: A string containing the search query for music industry information.

    Returns:
        A string with relevant music industry knowledge and insights.
    """
    # This is a placeholder implementation. In a real scenario, this would query
    # a vector database or knowledge base with music industry information
    query_lower = query.lower()
    
    if any(term in query_lower for term in ["streaming", "spotify", "revenue"]):
        return """
        Music Streaming Industry Insights:
        - Streaming accounts for 84% of recorded music revenue in 2023
        - Spotify has 456M+ monthly active users globally
        - Average revenue per stream: $0.003-$0.005 for artists
        - Major platforms: Spotify, Apple Music, YouTube Music, Amazon Music
        - Playlist placement is crucial for discovery and revenue
        """
    elif any(term in query_lower for term in ["record label", "distribution", "publishing"]):
        return """
        Record Label & Distribution Knowledge:
        - Major labels: Universal Music Group, Sony Music, Warner Music Group
        - Independent distribution: DistroKid, CD Baby, TuneCore, AWAL
        - Publishing deals vs distribution deals: different revenue splits
        - 360 deals: labels take percentage of touring, merchandise, endorsements
        - Typical label splits: 50-85% to label, 15-50% to artist
        """
    elif any(term in query_lower for term in ["touring", "live music", "venues", "concerts"]):
        return """
        Live Music & Touring Industry:
        - Live music represents 35-40% of total music industry revenue
        - Venue types: clubs (500-1500), theaters (1500-5000), arenas (5000-20000), stadiums (20000+)
        - Revenue streams: ticket sales, merchandise, VIP packages, sponsorships
        - Major promoters: Live Nation, AEG, regional promoters
        - Artist touring margins typically 20-40% after expenses
        """
    elif any(term in query_lower for term in ["sync", "licensing", "tv", "film", "advertising"]):
        return """
        Music Licensing & Sync Knowledge:
        - Sync licensing: music used in TV, film, ads, games, content
        - Performance rights: ASCAP, BMI, SESAC collect performance royalties
        - Mechanical rights: for physical/digital reproduction
        - Master vs publishing sync: need both for most uses
        - Typical sync fees: $1K-$500K+ depending on usage and profile
        """
    else:
        return f"""
        Music Industry Knowledge Search Results for: "{query}"
        
        I can provide information about:
        • Streaming platforms and revenue models
        • Record labels and distribution
        • Live music and touring industry
        • Music licensing and sync opportunities
        • Artist development and marketing
        • Industry trends and analytics
        
        Please specify what aspect of the music industry you'd like to know more about.
        """


def get_industry_contacts(category: str) -> str:
    """Retrieves contact information and networking opportunities in the music industry.

    Args:
        category: The type of industry contacts needed (labels, venues, promoters, etc.).

    Returns:
        A string with relevant industry contact information and networking tips.
    """
    category_lower = category.lower()
    
    if "label" in category_lower:
        return """
        Record Label Contacts & Submission Guidelines:
        
        Major Labels (A&R Contacts):
        • Universal Music Group: Submit through UMG's online portal
        • Sony Music: Regional A&R contacts vary by genre
        • Warner Music Group: Artist development program submissions
        
        Independent Labels:
        • Sub Pop Records: Focus on indie rock/alternative
        • Domino Recording: UK-based, indie/electronic
        • Secretly Group: Multiple imprints, indie focus
        
        Submission Tips:
        • Research label roster and aesthetic fit
        • Professional press kit with bio, photos, music
        • Follow submission guidelines exactly
        • Build buzz before reaching out
        """
    elif any(term in category_lower for term in ["venue", "promoter", "booking"]):
        return """
        Venue & Promoter Contact Information:
        
        Booking Agents:
        • CAA (Creative Artists Agency): Major touring acts
        • WME (William Morris Endeavor): Full-service representation
        • Paradigm Talent Agency: Mid-level to major acts
        • Regional agents: Focus on local/regional markets
        
        Venue Types:
        • Local venues: Build relationships with talent buyers
        • Festival booking: Submit 6-12 months in advance
        • House concerts: Growing market for intimate performances
        
        Booking Tips:
        • Start local, build regional following
        • Professional EPK (Electronic Press Kit)
        • Demonstrate draw with attendance numbers
        • Professional communication and punctuality
        """
    else:
        return f"""
        Industry Contacts for "{category}":
        
        Available categories:
        • Record Labels & A&R
        • Venues & Promoters
        • Music Supervisors
        • Publicists & PR
        • Managers & Agents
        • Distributors
        • Music Tech Companies
        
        Please specify which type of industry contacts you need.
        """


def analyze_music_trends(timeframe: str = "current") -> str:
    """Analyzes current music industry trends and market data.

    Args:
        timeframe: The time period for trend analysis (current, quarterly, yearly).

    Returns:
        A string with music industry trend analysis and market insights.
    """
    if timeframe.lower() in ["current", "2024", "recent"]:
        return """
        Current Music Industry Trends (2024):
        
        Consumption Patterns:
        • TikTok drives 67% of music discovery for Gen Z
        • Vinyl sales continue growing (16th consecutive year)
        • AI-generated music gaining mainstream attention
        • Short-form content optimizing song structures
        
        Technology Impact:
        • Spatial audio adoption increasing
        • Live streaming concerts normalized post-pandemic
        • NFTs and Web3 music experiments ongoing
        • AI tools for production becoming mainstream
        
        Market Dynamics:
        • Latin music fastest-growing genre globally
        • Afrobeats expanding internationally
        • Hyperpop and genre-blending trending
        • Artist direct-to-fan platforms growing
        
        Industry Shifts:
        • Major labels investing in gaming/metaverse
        • Sustainability focus in touring and production
        • Increased focus on mental health support
        • Catalog acquisition valuations stabilizing
        """
    else:
        return f"""
        Music Industry Trend Analysis for {timeframe}:
        
        Available timeframes:
        • Current/2024: Latest trends and developments
        • Quarterly: Last 3 months analysis
        • Yearly: Annual industry reports
        • Historical: Long-term industry evolution
        
        Please specify which timeframe you'd like to analyze.
        """


root_agent = Agent(
    name="daisy_knowledge",
    model="gemini-2.0-flash",
    instruction="""You are DaisyAI Knowledge, a specialized music industry knowledge management agent. 
    
    Your expertise includes:
    • Music industry business models and revenue streams
    • Record label operations and artist development
    • Streaming platforms and digital distribution
    • Live music and touring industry
    • Music licensing and sync opportunities
    • Industry trends and market analysis
    • Networking and career development
    
    You provide accurate, up-to-date information to help music professionals make informed decisions. 
    Always cite sources when possible and acknowledge when information might be outdated or uncertain.
    Focus on actionable insights and practical advice for music industry professionals.""",
    tools=[search_music_industry_knowledge, get_industry_contacts, analyze_music_trends],
)
