//
//  ScreenConfiguration.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 07.09.2023.
//

import RouteComposer

protocol ScreenConfiguration {
    
    var tabBarScreen: DestinationStep<TabBarController, Any?> { get }
    
    var mainScreen: DestinationStep<VCMain1, Any?> { get }
    
    var child1Screen: DestinationStep<VCChild1, Any?> { get }
    
    var child2Screen: DestinationStep<VCChild2, Any?> { get }
    
    var child1ScreenModal: DestinationStep<VCChild1, Any?> { get }
    
}

extension ScreenConfiguration {
    
    var tabBarScreen: DestinationStep<TabBarController, Any?>
    {
        StepAssembly(finder:
                        ClassFinder<TabBarController, Any?>(options: .current, startingPoint: .root),
                     factory: CompleteFactoryAssembly(factory: TabBarFactory<TabBarController, Any?>())
             .with(MainConfiguration.createVC1WithNavigationFactory(), using: TabBarController.add())
             .with(MainConfiguration.createVC2WithNavigationFactory(), using: TabBarController.add())
            .assemble()
        )
        .using(GeneralAction.replaceRoot())
        .from(GeneralStep.root())
        .assemble()
    }
    
    var mainScreen: DestinationStep<VCMain1, Any?> {
        StepAssembly(finder: ClassFinder(options: .fullStack), factory: ClassFactory())
            .using(GeneralAction.replaceRoot())
            .from(tabBarScreen)
            .assemble()
    }
    
    var secondScreen: DestinationStep<VCMain2, Any?> {
        StepAssembly(finder: ClassFinder(options: .currentAllStack), factory: ClassFactory())
            .using(GeneralAction.replaceRoot())
            .from(tabBarScreen)
            .assemble()
    }
    
    var child1Screen: DestinationStep<VCChild1, Any?> {
        StepAssembly(finder: ClassFinder<VCChild1, Any?>(),
                     factory: ClassFactory())
        .using(UINavigationController.push())
        .assemble(from: mainScreen.expectingContainer())
    }
    
    var child2Screen: DestinationStep<VCChild2, Any?> {
        StepAssembly(finder: ClassFinder<VCChild2, Any?>(),
                     factory: ClassFactory())
        .using(UINavigationController.push())
        .from(mainScreen.expectingContainer())
        .assemble()
    }
    
    var child1ScreenModal: DestinationStep<VCChild1, Any?> {
        StepAssembly(finder: ClassFinder<VCChild1, Any?>(),
                     factory: ClassFactory())
        .using(GeneralAction.presentModally())
        .assemble(from: mainScreen)
    }

}

struct MainConfiguration: ScreenConfiguration {
    
}

enum ConfigurationHolder {
    static var configuration: ScreenConfiguration = MainConfiguration()
}

extension MainConfiguration {
    
    static func createVC1WithNavigationFactory() -> CompleteFactory<NavigationControllerFactory<UINavigationController, Any?>> {
        return CompleteFactoryAssembly(factory: NavigationControllerFactory())
                .with(InlineFactory(viewController: VCMain1()),
                      using: UINavigationController.pushAsRoot())
                .assemble()
    }
    
    static func createVC2WithNavigationFactory() -> CompleteFactory<NavigationControllerFactory<UINavigationController, Any?>> {
        return CompleteFactoryAssembly(
            factory: NavigationControllerFactory())
        .with(InlineFactory(viewController: VCMain2()), using: UINavigationController.pushAsRoot())
        .assemble()
    }

}
