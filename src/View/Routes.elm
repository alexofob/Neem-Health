module View.Routes exposing (..)

import Types exposing (..)


-- Routes Config


dashboard : RouteItem
dashboard =
    { text = "Dashboard"
    , iconName = "dashboard"
    , route = Dashboard
    , subMenus = []
    , searchPlaceholder = Nothing
    }


drugCatalog : RouteItem
drugCatalog =
    { text = "Drug Catalog"
    , iconName = "store"
    , route = DrugCatalog
    , subMenus = []
    , searchPlaceholder = Just "Search for a Drug in the Catalog"
    }


orderManager : RouteItem
orderManager =
    { text = "Order Manager"
    , iconName = "shopping-cart"
    , route = OrderManager
    , subMenus = []
    , searchPlaceholder = Just "Search for an Order from a Pharmacy"
    }


userAdmin : RouteItem
userAdmin =
    { text = "User Admin"
    , iconName = "supervisor-account"
    , route = UserAdmin
    , subMenus = []
    , searchPlaceholder = Just "Search for an Account Manager"
    }


pharmacies : RouteItem
pharmacies =
    { text = "Phamarcies"
    , iconName = "maps:local-pharmacy"
    , route = Pharmacy
    , subMenus = []
    , searchPlaceholder = Just "Search for a Pharmacy"
    }


editProfile : RouteItem
editProfile =
    { text = "Profile"
    , iconName = "person"
    , route = EditProfile
    , subMenus = []
    , searchPlaceholder = Nothing
    }
